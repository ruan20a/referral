class AddColumnInviterEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :inviter_email, :string
  end
end
