# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  profile_id             :integer
#  company_name           :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  image                  :string(255)
#  industry               :string(255)
#  company_id             :integer
#  unique_token           :string(255)
#

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :whitelist
  has_many :jobs, :dependent => :destroy
  has_many :referrals, :through => :jobs
  belongs_to :company
  validates :email, :company, :first_name, :last_name, presence: true
  validates :email,  :uniqueness => { :case_sensitive => false }
  before_create :generate_unique_token
  before_create :generate_inviter_profile
  has_one :inviter_profile, :as => :owner

  scope :enterprise
  scope :main_admin

  def is_enterprise?
    self.company.level > 1 ? true:false
  end

  def is_main_admin?
    self.company.level > 2 ? true:false
  end

  def generate_unique_token
    self.unique_token = Digest::SHA1.hexdigest([Time.now,rand].join)
  end

  def generate_inviter_profile
    self.create_inviter_profile(:unique_token => self.unique_token)
  end

end
