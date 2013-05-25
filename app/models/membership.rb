# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin      :boolean
#

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  attr_accessible :group_id, :user_id, :admin
end
