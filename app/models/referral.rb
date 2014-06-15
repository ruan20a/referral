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
#  status               :string(255)      default("pending")
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
#

class Referral < ActiveRecord::Base

	belongs_to :job
	belongs_to :user
  has_one :email, :dependent => :destroy
  validates_presence_of :job_id, :ref_type
  #different logic for ask_referer types lambda substitute for method logic
  validates_presence_of :referee_email, :referee_name, :unless => lambda{ self.ref_type == "refer" }
  validates_uniqueness_of :referral_email, :scope => [:job_id, :user_id, :admin_id], :unless => lambda{ self.ref_type == "ask_refer"}
  #different logic for refer types lambda substitute for method logic
  validates_presence_of :referral_email, :referral_name, :linked_profile_url, :unless => lambda{ self.ref_type == "ask_refer" }
  #TODO - testing for before_update
  #on create need to change the date time.
  before_create :store_interest_update
  before_create :store_status_update
  #update when column changes
  before_update :store_interest_update, :if => :status_changed?
  before_update :store_status_update, :if => :is_interested_changed?
  before_update :check_notification, :if => :is_interested_changed?
  after_create :create_email
  before_update :status_change_email, :if => :status_changed?

  # has_paper_trail :only => [:is_interested, :status], :meta => [:store_interest_changes => :store_interest_update, :store_status_change => :store_status_update ]
  # before_save :check_email, :if => :referral_email_changed?
  # paginates_per 10

  def store_interest_update
    self.last_interest_update = Time.now
  end

  def store_status_update
    self.last_status_update = Time.now
  end

  def status_change_email
    # new_status = self.status
    # ReferralMailer.update_status_change(self)
  end

  def create_email
    referral = self
    Email.create(:referral_id => referral.id)
  end

  def check_notification
    referral = self

    if referral.is_interested == true && referral.email.admin_notification == false
      if referral.email.update_attribute(:admin_notification, true)
        ReferralMailer.deliver_admin_notification(referral)
        referral.save
      else
        #TODO render to the right page
        render 'edit', error: "We had an issue with your referral request. Please try again."
      end
    end
  end

  #TODO RETHINK LOGIC.
  def check_email(requester)
    referral = self
    if referral.referral_email_changed?
      if !referral.referral_email.nil?
        referral_email = referral.referral_email
        referral_email == requester.email ? false:true
      else
        true
      end
    else
      true
    end
  end
  #calculate is_interested status for user logic
  def return_is_interested_lag
    referral = self
    if referral.is_interested.nil?
      last_update = Date.parse(referral.last_interest_update.to_s)
      current_date = Date.parse(Time.now.to_s)
      days_lag = current_date - last_update
    else
      days_lag = 0
    end
  end
  #calculate pending status for admin logic
  def return_pending_status_lag
    referral = self
    if referral.email.admin_notification && referral.status == "Pending" && referral.is_interested == true
      last_update = Date.parse(referral.last_status_update.to_s)
      current_date = Date.parse(Time.now.to_s)
      days_lag = current_date - last_update
    else
      days_lag = 0
    end
  end

  def turn_inactive
    self.update_column(:is_active, false)
    #turn inactive after one week after the second admin notification or second user notification
  end

  def turn_active
    self.update_column(:is_active, true)
  end

end
