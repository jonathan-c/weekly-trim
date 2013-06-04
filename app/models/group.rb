# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  share_link :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  attr_accessible :name, :share_link
  has_many :memberships
  has_many :users, :through => :memberships
  
  validates :name, presence: :true
  
  def generate_link(user)
    Digest::MD5.hexdigest("#{self.created_at}#{user.id}")
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
  
  def mail_recent_posts
    self.users.each do |user|
      if user.subscribed?
        PostsMailer.posts_email(user, self.recent_posts).deliver
      end
    end
  end
  
  # def mail_post_reminders
  #   self.users.each do |user|
  #     if user.post_reminder? && # user has not posted since the last posts email
  #       PostsMailer.post_reminder(user).deliver
  #     end
  #   end
  # end
end
