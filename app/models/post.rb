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
  attr_accessible :title, :url, :user_id
  
  validates :title, presence: :true
  
  # scope :this_week, ->(created_at) {
  #   reservation = reserve_on.change(min: 0)
  #   
  #   where(
  #     "created_at >= ? AND created_at <= ?",
  #     created_at,
  #     reservation + 59.minutes
  #   )
  # }
  
  
  
end
