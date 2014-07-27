class AddInactiveToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :is_active, :boolean, :default => true
    remove_column :jobs, :speciality_2, :string
  end
end
