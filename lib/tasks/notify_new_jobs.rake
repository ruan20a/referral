namespace :notify_new_jobs do
  desc "Notify New Jobs to Users"
  task :email => :environment do
    #TODO NEED TO TEST
    run_day = Time.now.wday
    weekly_jobs = []
    #0 = Sunday .. 6 = Saturday
    if run_day == 2
      jobs = Job.all
      jobs.each do |job|
        if job.is_active == true
          if job.create_date < 8
            weekly_jobs << job
          end
        end
      end
    end

    JobMailer.deliver_job_notification(weekly_jobs)


  end
end