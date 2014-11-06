# == Schema Information
#
# Table name: referrals
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  referral_name        :string(255)
#  relationship         :string(255)
#  referral_email       :string(255)
#  additional_details   :string(255)
#  linked_profile_url   :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  status               :string(255)      default("Pending")
#  job_id               :integer
#  user_id              :integer
#  admin_id             :integer
#  github_profile_url   :string(255)
#  relevant             :boolean
#  relevance            :string(255)
#  ref_type             :string(255)
#  referee_email        :string(255)
#  personal_note        :text
#  referee_name         :string(255)
#  is_interested        :boolean
#  is_active            :boolean          default(TRUE)
#  last_status_update   :datetime         default(2014-06-11 00:32:29 UTC)
#  last_interest_update :datetime         default(2014-06-11 00:32:29 UTC)
#  referral_token       :string(255)
#  is_employee          :boolean          default(FALSE)
#  invited_by_ipf_id    :integer
#

class Referral < ActiveRecord::Base
  belongs_to :job
  belongs_to :user
  validates_presence_of :job_id, :ref_type
  validates :referral_email, uniqueness: {scope:[:job_id, :user_id, :admin_id]}, :unless => lambda{ self.ref_type == "ask_refer" }
  #validates :referral_email, uniqueness: {scope: :job_id, :user_id, :admin_id}
  validates_presence_of :referral_email, :referral_name, :unless => lambda{ self.ref_type == "ask_refer" }
  has_one :email
  after_create :create_email
  after_create :update_inviter_profile

  #different logic for ask_referer types lambda substitute for method logic
  # validates_presence_of :referee_email, :referee_name, :unless => lambda{ self.ref_type == "refer" }
  #different logic for refer types lambda substitute for method logic
  # validates_presence_of :referral_email, :referral_name, :unless => lambda{ self.ref_type == "ask_refer" }
  before_save :check_notification, :if => :is_interested_changed?
  before_save :check_successful_placement, :if => :status_changed?

  # before_save :check_email, :if => :referral_email_changed?

  #users
  scope :received_referrals, lambda{|user| where('referrals.referral_email = ? AND referrals.ref_type = ?', user.email, "refer")}
  scope :unreviewed, -> { where(is_interested: nil)}
  scope :sent_referrals, lambda {|user| where('referrals.ref_type = ? AND referrals.user_id = ?', "refer", user.id)}
  scope :requested_referrals, lambda {|user| where('referrals.referee_email = ? AND referrals.ref_type = ?', user.email, "ask_refer")}

  #admins
  scope :admin_referrals, lambda{|admin| joins(:job).where('jobs.admin_id = ?', admin.id)}
  scope :admin_active_referrals, lambda{|admin| joins(:job).where('jobs.admin_id = ? AND referrals.ref_type = ? AND referrals.is_active = ? AND referrals.is_interested = ?', admin.id, "refer", true, true)}
  scope :admin_inactive_referrals, lambda{|admin| joins(:job).where('jobs.admin_id = ? AND referrals.ref_type = ? AND referrals.is_active = ? AND referrals.is_interested = ?', admin.id, "refer", false, true)}

  #share
  scope :pending, lambda {where('referrals.status = ?', "Pending")}
  scope :interview, -> {where(status: "Interview")}
  scope :interview_offer, -> {where(status: "Interview - Offer")}
  scope :completed, -> {where(status: ["Pass", "Interview - No Offer", "Offer Declined", "Successful Placement"])}
  scope :success, -> {where(status: "Successful Placement")}



#SELECT "referrals".* FROM "referrals" INNER JOIN "jobs" ON "jobs"."id" = "referrals"."job_id" WHERE (jobs.admin_id = 1)
# TODO
  # scope :active
  # scope :inactive
  # paginates_per 10

  def update_inviter_profile
    inviter = InviterProfile.find(self.invited_by_ipf_id)
    referrals_num = inviter.referrals_generated
    inviter.update_attribute(:referrals_generated, referrals_num + 1)
  end

  def check_notification
    referral = self
    admin = referral.job.admin
    # binding.pry
    if referral.is_interested == true && referral.email.admin_notification == false
      if referral.email.update_attribute(:admin_notification, true)
        ReferralMailer.deliver_admin_notification(referral)
      else
        # TODO render to the right page
        render 'edit', error: "We had an issue with your referral request. Please try again."
      end
    end
  end

  #Not sure if this is necessary yet.
  def check_successful_placement
    referral = self
    binding.pry
    if referral.status == "Successful Placement"
      if referral.email.inviter_success_notification == false && !referral.invited_by_ipf_id.nil?
          # binding.pry
          ReferralMailer.deliver_inviter_success_notification(referral)
          referral.email.update_attribute(:inviter_success_notification, true)
      end

      if referral.email.referrer_success_notification == false
          # binding.pry
          ReferralMailer.deliver_referrer_success_notification(referral)
          referral.email.update_attribute(:referrer_success_notification, true)
      end
    end
  end


  def create_email
    referral_id = self.id
    Email.create(referral_id: referral_id)
  end

  #TODO RETHINK LOGIC. email issues in referrals.
  def check_email(requester)
    # binding.pry
    referral = self
    if referral.referral_email_changed?
      # binding.pry
      if !referral.referral_email.nil?
        # binding.pry
        referral_email = referral.referral_email
        # binding.pry
        referral_email == requester.email ? false:true
      else
        true
      end
    else
      true
    end
  end




end
