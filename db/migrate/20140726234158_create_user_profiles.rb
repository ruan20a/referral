class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :headline
      t.string :industry
      t.string :image
      t.string :public_profile_url
      t.string :location
      t.string :skills, array: true, default: '{}'
      t.json :positions
      t.json :educations
      t.timestamps
    end
  end
end
