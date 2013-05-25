# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  url        :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :url, :user_id
  
  validates :content, presence: :true
end
