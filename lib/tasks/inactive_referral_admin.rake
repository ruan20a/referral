namespace :inactive_referral_admin do
  desc "Set Referral to Inactive"
  task :check => :environment do

    emails = Email.all

    emails.each do |email|
      referral = email.referral
      if email.second_admin_reminder && referral.status == "Pending" && referral.is_active == true && referral.is_interested = true
        #second_admin_reminder should be the last thing on the email that is updated.
        days_lag = email.return_second_admin_lag
        puts "inactive admin #{referral.id} - email days_lag #{days_lag}"
        # checking how many days passed since last updated if second_user_reminder was sent
        if days_lag > 1
          referral.turn_inactive
        end
      end
    end
  end
end