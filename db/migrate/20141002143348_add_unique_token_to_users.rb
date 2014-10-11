class AddUniqueTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unique_token, :string, :unique => true
    User.all.each do |user|
      user.generate_unique_token
      user.save
    end
  end


end
