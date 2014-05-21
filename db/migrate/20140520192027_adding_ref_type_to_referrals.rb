class AddingRefTypeToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :ref_type, :string
  end
end
