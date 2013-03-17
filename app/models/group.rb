class Group < ActiveRecord::Base
  attr_accessible :name, :share_link
  has_and_belongs_to_many :users
end
