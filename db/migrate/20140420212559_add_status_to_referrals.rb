class AddStatusToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :status, :string
  end

end
