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
  
  after_create :is_http_url
  
  validates :title, presence: :true
  
  def is_http_url
    if !url.include?("http")
      self.update_attributes(url: "http://"+url)
    end
  end

  
end
