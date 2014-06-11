namespace :inactive_referral_user do
  desc "Set Referral to Inactive"
  task :check => :environment do

    emails = Email.all

    emails.each do |email|
      referral = email.referral
      if email.second_user_reminder && email.referral.is_interested == nil && referral.is_active == true
        #if first_admin_notification is not sent then is_interested for referral is still nil and admins have not touched it.
        days_lag = email.return_second_user_lag
        # checking how many days passed since last updated if second_user_reminder was sent
        puts "inactive user #{referral.id} - email days_lag #{days_lag}"
        if days_lag > 1
          referral.turn_inactive
        end
      end
    end
  end
end