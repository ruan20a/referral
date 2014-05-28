class CreateIndustryForJob < ActiveRecord::Migration
  def change
    add_column :jobs, :industry_1, :string
  end
end
