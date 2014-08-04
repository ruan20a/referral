# == Schema Information
#
# Table name: whitelists
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  level      :integer          default(1)
#

require 'test_helper'

class WhitelistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
