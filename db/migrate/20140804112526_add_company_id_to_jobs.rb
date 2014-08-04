class AddCompanyIdToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :company_id, :integer
    add_column :jobs, :is_public, :boolean, :default => true

    jobs = Job.all

    jobs.each do |job|
      company_name = job.name #TODO drop name soon.
      company = Company.where(:name => company_name)
      job.update_attribute(:company_id, company[0].id)
    end
  end

  def down
    remove_column :jobs, :company_id, :integer
    remove_column :jobs, :is_public, :integer
  end
end
