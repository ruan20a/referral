class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.string :invited_name
      t.string :invited_email
      t.boolean :is_successful, :default => false
      t.timestamps
    end
  end
end
