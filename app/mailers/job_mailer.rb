class JobMailer < ActionMailer::Base
  default from: ENV['GMAIL']
  add_template_helper(ApplicationHelper)
  include ActionView::Helpers::NumberHelper

  def deliver_jobs_notification(new_jobs)
    @new_jobs = new_jobs
    if @new_jobs.count > 0
      for user in User.all
        mail(to: user.email, subject: "Weekly New Position Posting").deliver
      end
    end
  end

  #to wekrut
  def deliver_approval_initiation(job)
    @job = job
    mail(to: ENV['GMAIL'], subject: "URGENT: Job Approval Needed for #{job.name} at #{job.company.name}")
  end

  #to admins #creator_id
  def deliver_approval_confirmation(job)
    @job = job
    job.company.admins.each do |admin|
      mail(to: admin.email , subject: "Approval Complete for #{@job.name} at #{@job.company.name}")
    end
  end

  #to admins #creator_id
  def deliver_approval_rejection(job)
    @job = job
    job.company.admins.each do |admin|
      @admin = admin
      mail(to: admin.email , subject: "Approval Denied for #{@job.name} at #{@job.company.name}")
    end
  end

end
