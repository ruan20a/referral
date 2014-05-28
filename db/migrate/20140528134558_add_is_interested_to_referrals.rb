class AddIsInterestedToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :is_interested, :boolean, :default => false
  end
end
