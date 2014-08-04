class AddReferralTokenToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :referral_token, :string
  end
end
