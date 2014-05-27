class AddAdminTypeToWhitelist < ActiveRecord::Migration
  def change
    add_column :whitelists, :is_admin, :boolean, :default => false
  end
end
