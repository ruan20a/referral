class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :admin_id
      t.integer :user_id

      t.timestamps
    end
  end
end
