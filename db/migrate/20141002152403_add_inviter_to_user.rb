class AddInviterToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :inviter_type
      t.integer :inviter_id
    end
  end
end
