namespace :pending_reminder_user do
  desc "Reminder Emails - Admin"
  task :check => :environment do

  referrals = Referral.all

  referrals.each do |referral|
    if referral.ref_type == "refer" && referral.is_interested.nil?
      receiver = referral.referral_email
      if referral.check_update_lag
        Referral.send_user_reminder(referral)
      end
    end
  end

end