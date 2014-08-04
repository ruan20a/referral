# == Schema Information
#
# Table name: authorizations
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  provider     :string(255)
#  uid          :string(255)
#  token        :string(255)
#  secret       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  profile_page :string(255)
#

require 'test_helper'

class AuthorizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
