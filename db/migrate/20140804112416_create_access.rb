class CreateAccess < ActiveRecord::Migration
  def up
    create_table :accesses do |t|
      t.integer :company_id
      t.integer :user_id
      t.integer :level, default: 1 #1 = Enterprise #2 = Super Admin (WeKrut)
    end
  end

  def down
    drop_table :accesses
  end
end

