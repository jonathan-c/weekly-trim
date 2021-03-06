# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  provider      :string(255)
#  uid           :string(255)
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  image         :string(255)
#  email         :string(255)
#  subscribed    :boolean          default(TRUE)
#  post_reminder :boolean          default(TRUE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :post_reminder, :subscribed, :email
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :posts
  
  validates :email, email_format: { message: "doesn't look like an email address" }, allow_blank: true
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      if auth["provider"] == 'facebook'
        user.email = auth["info"]["email"]
        user.image = auth["info"]["image"].sub("square", "normal")
      else
        user.image = auth["info"]["image"].sub("_normal", "")
      end
    end
  end
  
  def admin?(group)
    if group.memberships.find_by_user_id(id)
      group.memberships.find_by_user_id(id).admin
    else
      false
    end
  end
  
  def member?(group)
    self.memberships.find_by_user_id_and_group_id(self.id, group.id).present?
  end
  
  def unsubscribe_from_post_reminders
    self.post_reminder = false
  end
  
  def resubscribe_to_post_reminders
    self.post_reminder = true
  end
  
  def unsubscribe
    self.subscribed = false
  end
  
  def resubscribe
    self.subscribed = true
  end
  
  def this_weeks_posts(group)
    self.groups.find_by_id(group.id).posts.where(created_at: (Time.current.beginning_of_week..Time.current.end_of_week), user_id: self.id)
  end
  
  def join_group(group)
    membership = self.memberships.create(group_id: group.id, user_id: self.id)
    membership.save
  end
  
  def leave_group(group)
    # User cannot leave group if they're an admin
    if self != Group.find(group.id).admin
      Membership.find_by_user_id_and_group_id(self.id, group.id).destroy
    end
  end
end
