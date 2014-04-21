class CreateJoinTableAdminJob < ActiveRecord::Migration
  def change
    create_join_table :admins, :jobs do |t|
       t.index [:admin_id, :job_id]
       t.index [:job_id, :admin_id]
    end
  end
end
