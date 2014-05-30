class ChangeDefaultIsInterestedInReferrals < ActiveRecord::Migration
  def change
    change_column :referrals, :is_interested, :boolean, :default => nil
  end
end
