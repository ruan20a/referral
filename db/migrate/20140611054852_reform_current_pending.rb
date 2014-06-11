class ReformCurrentPending < ActiveRecord::Migration
  def change
    for referral in Referral.all
      if referral.status == "pending"
        referral.update_attribute(:status, "Pending")
      end
    end
  end
end
