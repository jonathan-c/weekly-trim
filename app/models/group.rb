# == Schema Information
#
# Table name: groups
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  share_link      :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  last_email_sent :datetime
#  token           :string(255)
#

class Group < ActiveRecord::Base
  attr_accessible :name, :share_link
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :posts
  
  before_create :set_token
  validates :name, presence: :true
  
  def generate_link
    Digest::MD5.hexdigest("#{self.created_at}#{self.id}")
  end
  
  def posted_this_week
    posted_this_week = []
     users.each do |user|
       if user.this_weeks_posts(self).present?
         posted_this_week<<user.name
       end
     end
     posted_this_week
  end
  
  def users_who_posted_this_week
    posted_this_week = []
     users.each do |user|
       if user.this_weeks_posts(self).present?
         posted_this_week<<user
       end
     end
     posted_this_week
  end
  
  def set_token
    self.token = SecureRandom.hex
  end
  
  def recent_posts
    posts = []
    self.users.each do |user|
      if !user.posts.last.nil?
        posts << user.posts.last
      end
    end
    posts
  end
  
  def send_posts
    self.touch(:last_email_sent)
    self.users.each do |user|
      if user.subscribed?
        PostsMailer.posts_email(user, self.recent_posts, self).deliver
      end
    end
  end
 
  def send_post_reminders
    self.users.each do |user|
      if user.post_reminder?
        if self.users_who_posted_this_week.include?(user) == false
          PostsMailer.post_reminder_email(user, self).deliver
        end
      end
    end
  end
  
  def admin
    User.find(Membership.find_by_group_id_and_admin(self.id, true).user_id)
  end
end
