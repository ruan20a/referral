class AddIdToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :job_id, :integer
    add_column :admins, :profile_id, :integer
  end
end
