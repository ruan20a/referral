class AddIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_id, :integer
    add_column :users, :referral_id, :integer
  end
end
