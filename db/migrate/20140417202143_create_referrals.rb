class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :name
      t.string :referral_name
      t.string :relationship
      t.string :referral_email
      t.string :additional_details
      t.string :linked_profile_url

      t.timestamps
    end
  end
end
