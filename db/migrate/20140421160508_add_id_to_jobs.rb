class AddIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :admin_id, :integer
    add_column :jobs, :referral_id, :integer
    add_column :jobs, :city, :string
    add_column :jobs, :state, :string
  end
end
