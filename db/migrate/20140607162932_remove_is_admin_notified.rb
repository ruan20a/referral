class RemoveIsAdminNotified < ActiveRecord::Migration
  def change
    remove_column :referrals, :is_admin_notified, :boolean
  end
end
