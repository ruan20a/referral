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

end
