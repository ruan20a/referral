# == Schema Information
#
# Table name: referrals
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  referral_name        :string(255)
#  relationship         :string(255)
#  referral_email       :string(255)
#  additional_details   :string(255)
#  linked_profile_url   :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  status               :string(255)      default("Pending")
#  job_id               :integer
#  user_id              :integer
#  admin_id             :integer
#  github_profile_url   :string(255)
#  relevant             :boolean
#  relevance            :string(255)
#  ref_type             :string(255)
#  referee_email        :string(255)
#  personal_note        :text
#  referee_name         :string(255)
#  is_interested        :boolean
#  is_active            :boolean          default(TRUE)
#  last_status_update   :datetime         default(2014-06-11 00:32:29 UTC)
#  last_interest_update :datetime         default(2014-06-11 00:32:29 UTC)
#  referral_token       :string(255)
#

require 'test_helper'

class ReferralTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
