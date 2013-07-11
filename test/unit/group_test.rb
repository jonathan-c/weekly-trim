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

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
