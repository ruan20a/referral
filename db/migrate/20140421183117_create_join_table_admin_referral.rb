class CreateJoinTableAdminReferral < ActiveRecord::Migration
  def change
    create_join_table :admins, :referrals do |t|
       t.index [:admin_id, :referral_id]
       t.index [:referral_id, :admin_id]
    end
  end
end
