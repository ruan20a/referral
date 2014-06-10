namespace :inactive_referral_user do
  desc "Set Referral to Inactive"
  task :check => :environment do

    emails = Email.all

    emails.each do |email|
      if email.second_user_reminder && !email.first_admin_notification
        #if first_admin_notification is not sent then is_interested for referral is still nil.
        days_lag = email.return_lag(second_user_reminder)
        referral = email.referral
        # checking how many days passed since last updated if second_user_reminder was sent
        if days_lag > 7
          referral.turn_inactive
        end
      end
    end
  end
end