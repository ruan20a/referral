class AddPersonalNoteToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :personal_note, :text
  end
end
