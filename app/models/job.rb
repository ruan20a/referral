# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  recruiter_id :integer
#  speciality_1 :string(255)
#  referral_fee :float
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
#  is_active    :boolean          default(TRUE)
#  min_salary   :float            default(0.0)
#  company_id   :integer
#  is_public    :boolean          default(TRUE)
#  is_approved  :boolean          default(FALSE)
#

class Job < ActiveRecord::Base
	belongs_to :admin
  belongs_to :company
  has_many :accesses, :through  => :company
	has_many :referrals, :dependent => :destroy
	has_many :users, :through => :referrals
  validates_presence_of :referral_fee, :name, :job_name, :city, :state, :description, :is_active, :is_public
  before_update :check_inactive, :if => :is_active_changed?
  scope :private, -> { where(is_public: false) }
  scope :public, -> { where(is_public: true) }
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
  scope :approved, -> { where(is_approved: true) }
  scope :unapproved, -> { where(is_approved: false) }
  after_create :initiate_approval
  before_update :check_approval, :if => :is_approved_changed?

  # scope :selected_users, lambda { |user|
  #   joins(:access).where('access.user = ?', email)
  # }

  # scope :published, -> { where(published: true) }
  # has_paper_trail #TODO - to undo remove/inactive jobs later
  # scope :selected_user, lambda { |user| self.private.select{|job| Access.exists?(user_id: user.id, company_id: job.company_id)} }

  # joins(:accessesx`).where('accesses.user = ?', user)}


  # scope :by_email, lambda do |email|
  #   joins(:profile).where('profile.email = ?', email) unless email.nil?
  # end
    # Access.exists?(user_id: user.id, company_id: company_id) }


  # scope :by_user, lambda { |user|
  #   where(:owner_id => user.id) unless user.admin?
  # }

# |user|
    # where(:owner_id => user.id) unless user.admin?
  # scope :published, lambda {
  # joins(:posts).group("users.id") & Post.published
# }

  #TODO test


  def generate_url
  end

  def initiate_approval
    job = self
    JobMailer.deliver_approval_initiation(job)
  end

  #TODO test
  def check_approval
    if self.is_approved
      JobMailer.deliver_approval_confirmation(job)
    else
      JobMailer.deliver_approval_rejection(job)
    end
  end

  def check_inactive
    referrals = self.referrals
    if !self.is_active
      referrals.each {|referral| referral.turn_inactive}
    else
      referrals.each {|referral| referral.turn_active}
    end
  end

  def check_days_since_creation
    create_date = Date.parse(self.created_at.to_s)
    current_date = Date.parse(Time.now.to_s)
    days_lag = current_date - create_date
  end

  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end
 end
