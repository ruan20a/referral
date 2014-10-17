# == Schema Information
#
# Table name: inviter_profiles
#
#  id                  :integer          not null, primary key
#  unique_token        :string(255)
#  owner_id            :integer
#  owner_type          :string(255)
#  users_generated     :integer          default(0)
#  referrals_generated :integer          default(0)
#  created_at          :datetime
#  updated_at          :datetime
#

class InviterProfile < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
end
