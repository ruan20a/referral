class AddMinSalaryAndCorrectReferralFeeToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :min_salary, :float, :default => 0.00

    for job in Job.all
      referral_fee = job.referral_fee
      min_salary = referral_fee/0.05
      job.update_attribute(:min_salary, min_salary)
    end

    change_column :jobs, :referral_fee, :float
  end

  def down
    remove_column :jobs, :min_salary, :float
    change_column :jobs, :referral_fee, :integer
  end
end
