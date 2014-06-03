class AddWhitelistLevels < ActiveRecord::Migration
  def change
    add_column :whitelists, :level, :integer
  end
end
