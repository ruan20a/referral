class AddIndustryAndImageToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :image, :string
    add_column :admins, :industry, :string
  end
end
