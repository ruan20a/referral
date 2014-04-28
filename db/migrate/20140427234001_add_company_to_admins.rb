class AddCompanyToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :company, :string
  end
end
