class AddCompanyIdToAdmins < ActiveRecord::Migration
  def up
    add_column :admins, :company_id, :integer

    admins = Admin.all

    admins.each do |admin|
      company_name = admin.company_name #TODO drop company_name
      unless company_name.nil?
        company = Company.find_by_name(company_name)
        admin.update_attribute(:company_id,company.id)
      end
    end
  end

  def down
    remove_column :admins, :company_id, :integer
  end
end