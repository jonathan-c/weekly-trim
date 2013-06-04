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
  attr_accessible :name, :provider, :uid, :post_reminder, :subscribed
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :posts
  
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
    group.memberships.find_by_user_id(self.id).admin
  end
  
  def member?(group)
    self.memberships.find_by_group_id(group.id).nil? ? false : true
  end
  
  def unsubscribe_from_post_reminders
    self.post_reminder = false
  end
  
  def unsubscribe
    self.subscribed = false
  end
  
  def resubscribe
    self.subscribed = true
  end
end
