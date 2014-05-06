class AddAdminIdToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :admin_id, :integer
  end
end
