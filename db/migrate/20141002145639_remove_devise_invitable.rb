class RemoveDeviseInvitable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove   :invitation_created_at
      t.remove   :invitation_sent_at
      t.remove    :invitation_accepted_at
      t.remove     :invitation_limit
      t.remove     :invitations_count
      t.remove     :invitation_token
      t.remove     :invited_by_id
      t.remove     :invited_by_type
    end

    change_table :admins do |t|
      t.remove   :invitation_created_at
      t.remove   :invitation_sent_at
      t.remove    :invitation_accepted_at
      t.remove     :invitation_limit
      t.remove     :invitations_count
      t.remove     :invitation_token
      t.remove     :invited_by_id
      t.remove     :invited_by_type
      t.string     :referral_token
    end
  end


end
