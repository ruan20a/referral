class CreateUserWhitelists < ActiveRecord::Migration
  def change
    create_table :user_whitelists do |t|
      t.string :email

      t.timestamps
    end
  end
end
