class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :description
      t.integer :recruiter_id
      t.string :speciality_1
      t.string :speciality_2
      t.integer :referral_fee

      t.timestamps
    end
  end
end
