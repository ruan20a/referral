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
#

class Job < ActiveRecord::Base
	belongs_to :admin
  belongs_to :company
  has_many :accesses, :through  => :company
	has_many :referrals, :dependent => :destroy
	has_many :users, :through => :referrals
  validates_presence_of :referral_fee, :name, :job_name, :city, :state, :description
  before_update :check_inactive, :if => :is_active_changed?
  scope :private, -> { where(is_public: false) }
  scope :public, -> { where(is_public: true) }
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

  def self.enterprise_admin(admin)
    self.private.select{|job| admin.company == job.company}
  end

  # def self.selected_user(user)
  #   if status.present?
  #     where(status: status)
  #   end
  #     # Access.exists?(user_id: user.id, company_id: self.company_id)
  # end

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

 end
