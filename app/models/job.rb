# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
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
#  industry_1   :string(255)
#

class Job < ActiveRecord::Base
	belongs_to :admin
	has_many :referrals, :dependent => :destroy
	has_many :users, :through => :referrals
  validates_presence_of :referral_fee, :name, :job_name, :city, :state, :description
	mount_uploader :image, ImageUploader
  before_update :check_inactive, :if => :is_active_changed?

  def check_inactive
    referrals = self.referrals
    if !self.is_active
      referrals.each {|referral| referral.turn_inactive}
    else
      referrals.each {|referral| referral.turn_active}
    end
  end


end
