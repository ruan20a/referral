class AddStatusDefaultToReferrals < ActiveRecord::Migration
  def change
    change_column :referrals, :status, :string, :default => "pending"
  end
end
