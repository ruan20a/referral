class ChangeColumnNameForCompany < ActiveRecord::Migration
  def change
    rename_column :admins, :company, :company_name #avoid issues later
  end
end
