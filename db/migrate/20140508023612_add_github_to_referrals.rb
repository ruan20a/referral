class AddGithubToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :github_profile_url, :string
  end
end
