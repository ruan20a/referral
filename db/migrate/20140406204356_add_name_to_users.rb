class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :industry_1, :string
    add_column :users, :industry_2, :string
    add_column :users, :speciality_1, :string
    add_column :users, :speciality_2, :string
  end
end
