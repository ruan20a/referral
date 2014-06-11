class LastStatusUpdateToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :last_status_update, :datetime, :default => Time.now

    for referral in Referral.all
      referral.update_attribute(:last_status_update, referral.updated_at)
    end
  end
end
