# == Schema Information
#
# Table name: referrals
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  referral_name      :string(255)
#  relationship       :string(255)
#  referral_email     :string(255)
#  additional_details :string(255)
#  linked_profile_url :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  status             :string(255)
#  job_id             :integer
#  user_id            :integer
#  admin_id           :integer
#  github_profile_url :string(255)
#  relevant           :boolean
#  relevance          :string(255)
#

class Referral < ActiveRecord::Base
	belongs_to :job
	belongs_to :user
  validates_presence_of :job_id, :ref_type
  #different logic for ask_refer types lambda substitute for method logic
  validates_presence_of :referral_email, :referral_name, :unless => lambda{ self.ref_type == "refer" }
end
