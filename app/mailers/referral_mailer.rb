class ReferralMailer < ActionMailer::Base
  default from: ENV['GMAIL']

  def deliver_ref_email(referral, admin)
    #TODO logic needs upgrade for admin
    @referral = referral
    @referral_id = referral.id
    # binding.pry

    if referral.user_id.nil?
      sender = Admin.find(referral.admin_id)
    else
      sender = User.find(referral.user_id)
    end

    @sender_first_name = sender.first_name
    @sender_last_name = sender.last_name

    @admin_email = admin.email
    @admin_name = admin.first_name

    job = Job.find(referral.job_id)
    @job_name = job.name.titleize

    mail(to: @admin_email, subject: "New Referral for Job #{@job_name}").deliver
  end

  def deliver_ask_email(referral, requester)

    @referee_email = referral.referee_email
    @referee_name = referral.referee_name
    @job = Job.find(referral.job_id)
    # binding.pry
    @requester_FN = requester.first_name
    @requester_LN = requester.last_name
    @requester_email = requester.email

    mail(to: @referee_email, subject: "Referral Request from #{@requester_FN.titleize} #{@requester_LN.titleize}").deliver
  end
end
