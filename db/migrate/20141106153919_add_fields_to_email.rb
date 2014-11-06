class AddFieldsToEmail < ActiveRecord::Migration
  def change
    change_table :emails do |t|
      t.boolean :inviter_success_notification, default: false
      t.boolean :referrer_success_notification, default: false
    end
  end
end
