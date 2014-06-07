namespace :pending_reminder_user do
  desc "Reminder Emails - User"
  task :check => :environment do

    referrals = Referral.all

    referrals.each do |referral|
      if referral.ref_type == "refer"
        receiver = referral.referral_email
        days_lag = referral.return_is_interested_lag

        if days_lag > 3
          if !referral.email.first_user_reminder
            referral.email.update_attributes(:first_user_reminder => true)
            ReferralMailer.send_user_reminder(referral, 1)
          end
        end

        if days_lag > 10
          if !referral.email.second_user_reminder && referral.email.first_user_reminder
            referral.email.update_attributes(:second_user_reminder => true)
            ReferralMailer.send_user_reminder(referral, 2)
          end
        end

      end

    end

  end
end