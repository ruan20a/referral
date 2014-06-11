class ChangeDefaultToPendingForReferrals < ActiveRecord::Migration
  def change
    change_column :referrals, :status, :string, :default => "Pending"
  end
end
