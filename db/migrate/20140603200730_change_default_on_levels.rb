class ChangeDefaultOnLevels < ActiveRecord::Migration
  def change
    change_column :whitelists, :level, :integer, :default => 1
  end
end
