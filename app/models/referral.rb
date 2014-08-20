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
#

class Referral < ActiveRecord::Base
  belongs_to :job
  belongs_to :user
  validates_presence_of :job_id, :ref_type
  validates_uniqueness_of :referral_email, :scope => [:job_id, :user_id, :admin_id], :unless => lambda{ self.ref_type == "ask_refer"}
  validates_presence_of :referral_email, :referral_name, :linked_profile_url, :unless => lambda{ self.ref_type == "ask_refer" }
  has_one :email
  after_create :create_email

  #different logic for ask_referer types lambda substitute for method logic
  # validates_presence_of :referee_email, :referee_name, :unless => lambda{ self.ref_type == "refer" }
  #different logic for refer types lambda substitute for method logic
  # validates_presence_of :referral_email, :referral_name, :unless => lambda{ self.ref_type == "ask_refer" }
  before_save :check_notification, :if => :is_interested_changed?
  # before_save :check_email, :if => :referral_email_changed?

  # paginates_per 10


  def check_notification
    referral = self
    admin = referral.job.admin
    # binding.pry

    if referral.is_interested == true && referral.email.admin_notification == false
      if referral.email.update_attribute(:admin_notification, true)
        ReferralMailer.deliver_admin_notification(referral)
        referral.save
      else
        # TODO render to the right page
        render 'edit', error: "We had an issue with your referral request. Please try again."
      end
    end
  end

  def create_email
    referral_id = self.id
    Email.create(referral_id: referral_id)
  end
  #TODO RETHINK LOGIC.
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
