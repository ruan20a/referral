class CreateCompany < ActiveRecord::Migration
  def up
    create_table :companies do |t|
      t.string :name
      t.string :image
      t.string :access_token
      t.text :address_line_1
      t.text :address_line_2
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.integer :level, default: 1 #1 for Basic #2 Enterprise
      t.text :description
      t.string :industry
      t.timestamps
    end

    companies = []
    jobs = Job.all
    jobs.each{ |job|
      companies << job.name #drop this
    }

    admins = Admin.all
    admins.each {|admin|
      companies << admin.company_name
    }

    companies.uniq!

    companies.each do |company|
      Company.create(:name => company)
    end

  end

  def down
    drop_table :companies
  end
end
