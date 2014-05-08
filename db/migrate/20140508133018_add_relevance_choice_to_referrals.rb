class AddRelevanceChoiceToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :relevance, :string
  end
end
