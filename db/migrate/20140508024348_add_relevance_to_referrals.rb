class AddRelevanceToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :relevant, :boolean
  end
end
