class AddApprovalToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :is_approved, :boolean, :default => false
    update <<-SQL
    UPDATE
      jobs
    SET is_approved = true
    SQL
  end
end
