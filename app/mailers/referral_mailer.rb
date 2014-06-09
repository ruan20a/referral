class ReferralMailer < ActionMailer::Base
  default from: ENV['GMAIL']

  include ApplicationHelper

  def deliver_ref_email(referral)
    @referral = referral
    @referral_id = referral.id

    set_sender(@referral)

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

  def deliver_admin_notification(referral)
    #binding.pry
    @referral = referral
    set_admin(@referral)

    #TODO FACTOR THIS OUT (METHOD)!!
    set_sender(@referral)

    @job = Job.find(@referral.job_id)
    @job_referral_fee = @job.referral_fee / 2

    mail(to: @admin_email,subject: "New Referral for Job #{@job.name}").deliver
  end


  # def send_admin_reminder(referral)
  #   if referral.is_interested == true && referral.status == "pending"
  #     if referral.check_time_update
  #   end
  # end

  def send_user_reminder(referral,num_of_times)
    @referral = referral
    @num_of_times = num_of_times
    @receiver_name = @referral.referral_name
    @receiver_email = @referral.referral_email

    set_sender(referral)

    if @num_of_times == 1
      mail(to: @receiver_email,subject: "Reminder - Please indicate your interest for your referral").deliver
    else
      mail(to: @receiver_email,subject: "Last Reminder - Please indicate your interest for your referral").deliver
    end
  end


  def send_admin_reminder(referral,num_of_times)
    @referral = referral
    @num_of_times = num_of_times
    set_sender(@referral)
    set_admin(@referral)

    if @num_of_times == 1
      mail(to: @admin_email,subject: "Reminder - Please update the referral status for your #{referral.job.job_name} posting").deliver
    else
      mail(to: @admin_email,subject: "Last Reminder - Please update referral status for your #{referral.job.job_name} posting").deliver
    end
  end

  protected

  def set_sender(referral)
    if referral.user_id.nil?
      sender = Admin.find(referral.admin_id)
    else
      # binding.pry
      sender = User.find(referral.user_id)
    end

    @sender_first_name = sender.first_name
    @sender_last_name = sender.last_name
    @sender_email = sender.email
  end

  def set_admin(referral)
    @admin_FN = referral.job.admin.first_name
    @admin_LN = referral.job.admin.last_name
    @admin_email = referral.job.admin.email
  end

end
