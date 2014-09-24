class AddIsEmployeeToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :is_employee, :boolean, default: false
  end
end
