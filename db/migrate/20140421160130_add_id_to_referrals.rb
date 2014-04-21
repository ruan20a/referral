class AddIdToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :job_id, :integer
    add_column :referrals, :user_id, :integer
  end
end
