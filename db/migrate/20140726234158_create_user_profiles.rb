class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :email_address
      t.string :first_name
      t.string :last_name
      t.string :headline
      t.string :industry
      t.string :image
      t.string :public_profile_url
      t.string :location
      t.string :skills, array: true, default: '{}'
      t.string :educations, array: true, default: '{}'
      t.string :positions, array: true, default: '{}'
      t.string :user_id
      t.timestamps
    end
  end
end
