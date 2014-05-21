class ReferralMailer < ActionMailer::Base
  default from: ENV['GMAIL']

  def deliver_ref_email(referral, admin)
    #TODO logic needs upgrade for admin
    @referral = referral
    @referral_id = referral.id

    sender = User.find(referral.user_id)
    @sender_first_name = sender.first_name
    @sender_last_name = sender.last_name

    @admin_email = admin.email
    @admin_name = admin.first_name

    job = Job.find(referral.job_id)
    @job_name = job.name.titleize

    mail(to: @admin_email, subject: "New Referral for Job #{@job_name}").deliver
  end

  def deliver_ask_email(referral, requester)
    @referral_email = referral.referral_email
    @referral_name = referral.referral_name

    @job = Job.find(referral.job_id)
    binding.pry
    @requester = requester

    mail(to: @referral_email, subject: "Referral Request from #{@requester.first_name.titleize} #{@requester.last_name.titleize} ").deliver
  end
end
