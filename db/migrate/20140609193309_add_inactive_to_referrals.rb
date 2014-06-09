class AddInactiveToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :is_active, :boolean, :default => :true
  end
end
