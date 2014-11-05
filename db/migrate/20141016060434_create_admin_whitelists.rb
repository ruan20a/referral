class CreateAdminWhitelists < ActiveRecord::Migration
  def change
    create_table :admin_whitelists do |t|
      t.integer :company_id
      t.string :email, :unique => true
      t.integer :level, :default => 1 #1 = read access #2 = write access
      t.timestamps
    end
  end
end
