class AddProfilePageToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :profile_page, :string
  end
end
