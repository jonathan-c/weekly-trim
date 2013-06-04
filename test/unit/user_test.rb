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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
