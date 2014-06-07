class AddNewEmailModel < ActiveRecord::Migration
  def up
    create_table :emails do |t|
      t.integer :referral_id
      t.boolean :admin_notification, :default => false
      t.boolean :first_admin_reminder, :default => false
      t.boolean :first_user_reminder, :default => false
      t.boolean :second_admin_reminder, :default => false
      t.boolean :second_user_reminder, :default => false
    end

    for referral in Referral.all
      if referral.is_admin_notified == true
        email = Email.create(:referral_id => referral.id, :admin_notification => true)
      else
        email = Email.create(:referral_id => referral.id)
      end
    end

  end

  def down
    drop_table :emails
  end
end
