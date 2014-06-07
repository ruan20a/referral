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
#  status             :string(255)      default("pending")
#  job_id             :integer
#  user_id            :integer
#  admin_id           :integer
#  github_profile_url :string(255)
#  relevant           :boolean
#  relevance          :string(255)
#  ref_type           :string(255)
#  referee_email      :string(255)
#  personal_note      :text
#  referee_name       :string(255)
#  is_interested      :boolean
#  is_admin_notified  :boolean          default(FALSE)
#

class Referral < ActiveRecord::Base
	belongs_to :job
	belongs_to :user
  validates_presence_of :job_id, :ref_type
  #different logic for ask_referer types lambda substitute for method logic
  # validates_presence_of :referee_email, :referee_name, :unless => lambda{ self.ref_type == "refer" }
  validates_uniqueness_of :referral_email, :scope => [:job_id, :user_id], :unless => lambda{ self.ref_type == "ask_refer"}
  #different logic for refer types lambda substitute for method logic
  # validates_presence_of :referral_email, :referral_name, :linked_profile_url, :unless => lambda{ self.ref_type == "ask_refer" }
  before_save :check_notification, :if => :is_interested_changed?
  # before_save :check_email, :if => :referral_email_changed?

  # paginates_per 10

  def check_notification
    referral = self
    admin = referral.job.admin

    if referral.is_interested == true && referral.is_admin_notified == false
      if referral.update_attribute(:is_admin_notified, true)
        ReferralMailer.deliver_admin_notification(referral, admin)
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

  def check_update_lag
    #testing required to update referral.updated_at
    referral = self
    last_update = referral.updated_at
    time_passage = Time.now - last_update
    time_passage > 1209600 ? true:false
  end


end
