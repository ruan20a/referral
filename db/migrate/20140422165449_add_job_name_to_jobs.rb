class AddJobNameToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :job_name, :string
  end
end
