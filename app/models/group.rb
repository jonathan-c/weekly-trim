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
end
