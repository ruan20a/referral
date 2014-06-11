namespace :inactive_referral_not_interested do

  desc "Set Referral to Inactive if Not Interested"
  task :check => :environment do

    referrals = Referral.all

    referrals.each do |email|
      referral = email.referral
      if referral.is_interested == false && referral.is_active == true
        #if first_admin_notification is not sent then is_interested for referral is still nil and admins have not touched it.
        days_lag = referral.return_is_interested_lag
        # checking how many days passed since last updated if second_user_reminder was sent
        puts "inactive is_interested_lag #{referral.id} - email days_lag #{days_lag}"
        if days_lag > 1
          referral.turn_inactive
        end
      end
    end
  end





end