class AddWhitelistLevels < ActiveRecord::Migration
  def change
    add_column :whitelists, :level, :integer, :default => 3
    update <<-SQL
      UPDATE
        whitelists
      SET level = (CASE WHEN (is_admin = true)
        THEN
          2
        ELSE
          1
      END)
    SQL
    remove_column :whitelists, :is_admin
  end
end
