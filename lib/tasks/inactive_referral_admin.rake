namespace :inactive_referral_active do
  desc "Set Referral to Inactive"
  task :check => :environment do

    emails = Email.all

    emails.each do |email|
      referral = email.referral
      if email.second_admin_reminder && referral.status == "pending"
        #if first_admin_notification is not sent then is_interested for referral is still nil.
        days_lag = referral.return_pending_status_lag
        # checking how many days passed since last updated if second_user_reminder was sent
        if days_lag > 7
          referral.turn_inactive
        end
      end
    end
  end
end