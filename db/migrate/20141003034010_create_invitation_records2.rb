class SetupInviterProfile < ActiveRecord::Migration
  def change
    create_table :inviter_profiles do |t|
      t.string :unique_token, :unique => true #unique token
      t.references :owner, :polymorphic => true
      # t.integer :owner_id #user or admin id
      # t.string  :owner_type #user or admin type
      t.integer :successful_user_invites, :default => 0 #number of created users
      t.integer :successful_job_referrals, :default => 0 #number of created job referrals
      t.timestamps
    end

    change_table :users do |t|
      t.remove :referral_id
      t.remove :linked_in
      t.remove :inviter_email
      t.remove :provider
      t.remove :inviter_type
      t.remove :inviter_id
    end

    change_table :admins do |t|
      t.remove :job_id
    end

    add_column :users, :invited_by_ipf_id, :integer
    add_column :jobs, :invited_by_ipf_id, :integer
    add_index :users, :invited_by_ipf_id
    add_index :jobs, :invited_by_ipf_id


    User.all.each do |user|
      inviter = user.generate_inviter_profile
      #reference by user.inviter_profile
    end

    Admin.all.each do |admin|
      inviter = admin.generate_inviter_profile
    end

  end
end
