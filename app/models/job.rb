# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :string(255)
#  recruiter_id :integer
#  speciality_1 :string(255)
#  speciality_2 :string(255)
#  referral_fee :integer
#  created_at   :datetime
#  updated_at   :datetime
#  admin_id     :integer
#  referral_id  :integer
#  city         :string(255)
#  state        :string(255)
#  job_name     :string(255)
#  logo_url     :string(255)
#  image        :string(255)
#

class Job < ActiveRecord::Base
	belongs_to :admin
	has_many :referrals
	has_many :users, :through => :referrals

	mount_uploader :image, ImageUploader

end
