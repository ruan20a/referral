class AddRefereeNameToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :referee_name, :string
  end
end
