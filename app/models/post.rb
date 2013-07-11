# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  url        :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  attr_accessible :title, :url, :user_id, :group_id
  
  validates :title, presence: :true

  def this_weeks_posts
    Post.where(created_at: (Time.zone.now.beginning_of_week..Time.zone.now.end_of_week))
  end  
  
end
