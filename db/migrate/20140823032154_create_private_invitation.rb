class CreatePrivateInvitation < ActiveRecord::Migration
  def change
    create_table :private_invitations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :company_id
      t.boolean :is_active, default: false
      t.integer :num_of_invites, default: 1
    end
  end
end
