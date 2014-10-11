class AddUniqueTokenToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :unique_token, :string, :unique => true
    Admin.all.each do |admin|
      admin.generate_unique_token
      admin.save
    end
  end
end
