class AddReferralEmailNotificationToAdmin < ActiveRecord::Migration
  def change
    add_column :referrals, :is_admin_notified, :boolean, default: false
  end
end
