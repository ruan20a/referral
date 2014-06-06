class ReferralMailer < ActionMailer::Base
  default from: ENV['GMAIL']

  include ApplicationHelper

  def deliver_ref_email(referral)
    #TODO logic needs upgrade for admin
    @referral = referral
    @referral_id = referral.id
    binding.pry

    if referral.user_id.nil?
      sender = Admin.find(referral.admin_id)
    else
      binding.pry
      sender = User.find(referral.user_id)
    end

    @sender_first_name = sender.first_name
    @sender_last_name = sender.last_name
    @sender_email = sender.email

    # @admin_email = admin.email
    # @admin_name = admin.first_name

    @receiver_name = @referral.referral_name
    @receiver_email = @referral.referral_email


    @job = @referral.job
    @job_name = @job.name.titleize

    mail(to: @receiver_email,subject: "New Referral for Job #{@job_name}", cc: @sender_email).deliver

  end

  def deliver_ask_email(referral, requester)
    referee_email = referral.referee_email
    @referee_name = referral.referee_name
    @job = referral.job

    # binding.pry
    @requester_FN = requester.first_name
    @requester_LN = requester.last_name
    requester_email = requester.email

    mail(to: referee_email, subject: "Referral Request from #{@requester_FN} #{@requester_LN}").deliver
    mail(to: requester_email, subject: "Copy of your referral request to #{@referee_name}").deliver
  end

  def deliver_admin_notification(referral, admin)
    #binding.pry

    @referral = referral

    @admin_FN = admin.first_name
    @admin_LN = admin.last_name
    admin_email = admin.email

    #TODO FACTOR THIS OUT (METHOD)!!
    if @referral.user_id.nil?
      sender = Admin.find(referral.admin_id)
    else
      sender = User.find(referral.user_id)
    end

    @sender_first_name = sender.first_name
    @sender_last_name = sender.last_name
    sender_email = sender.email

    @job = Job.find(@referral.job_id)
    @job_referral_fee = @job.referral_fee / 2

    mail(to: admin_email,subject: "New Referral for Job #{@job.name}").deliver
  end


  # def send_admin_reminder(referral)
  #   if referral.is_interested == true && referral.status == "pending"
  #     if referral.check_time_update
  #   end
  # end

  def send_user_reminder(referral)

  end
end
