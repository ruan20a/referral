# == Schema Information
#
# Table name: users
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
#  first_name             :string(255)
#  last_name              :string(255)
#  industry_1             :string(255)
#  industry_2             :string(255)
#  speciality_1           :string(255)
#  speciality_2           :string(255)
#  profile_id             :integer
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  tagline                :string(255)
#  uid                    :string(255)
#  unique_token           :string(255)
#  invited_by_ipf_id      :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :validatable
  SOCIALS = {
    facebook: 'Facebook',
    github: 'Github',
    linkedin: 'Linkedin'
  }
  has_one :inviter_profile, :as => :owner, :dependent => :destroy
  has_one :user_profile, :dependent => :destroy
  belongs_to :whitelist
  has_many :referrals, :dependent => :destroy
  has_many :authorizations, :dependent => :destroy
  has_many :jobs, :through => :referrals
  has_many :accesses
  has_many :companies, :through => :accesses
  validates :first_name, :last_name, :email, presence: true
  validates :email, :uniqueness => { :case_sensitive => false }
  scope :private_company, lambda {|company| joins(:accesses).where('accesses.company_id = ?', company.id)}
  before_create :generate_unique_token
  before_create :generate_inviter_profile
  after_create :update_inviter_profile


  def update_inviter_profile
    inviter = InviterProfile.find(self.invited_by_ipf_id)
    referrals_num = inviter.users_generated
    inviter.update_attribute(:users_generated, referrals_num + 1)
  end

  def generate_unique_token
    self.unique_token = Digest::SHA1.hexdigest([Time.now,rand].join)
  end

  def generate_inviter_profile
    #has_one (create_inviter_profile) vs. has_many (inviter_profile.create)
    self.create_inviter_profile(:unique_token => self.unique_token)
  end

  def has_enterprise? #true to display private
    self.accesses.count > 0 ? true : false
  end

 def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.from_omniauth(auth, current_user, access_token=nil, ipf_id) #default is nil
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where("email = ?", auth["info"]["email"]).first : current_user
      if user.blank?
        user = User.new
        user.create_user(auth, user, ipf_id)
      end
     authorization.user_id = user.id
     authorization.save
   end
    # binding.pry
    authorization.user.check_access_token(access_token, authorization.user_id) unless access_token.nil?
    authorization.user.create_profile(auth, authorization.user)
    authorization.user
 end

 def create_user(auth, user, ipf_id)
  # binding.pry
  user.password = auth["credentials"]["token"]
  #Devise.friendly_token[0,10]
  user.first_name = auth.info.first_name
  user.last_name = auth.info.last_name
  user.email = auth.info.email
  user.invited_by_ipf_id = ipf_id
  user.save
  create_profile(auth, user)
 end

 def create_profile(auth, user)
  profile = UserProfile.find_or_initialize_by(user_id: user.id)
  profile.user_id = user.id
  profile.first_name = auth["info"].fetch("first_name") { nil }
  profile.last_name = auth["info"].fetch("last_name") { nil }
  profile.email = auth["info"].fetch("email") { nil }
  profile.location = auth["info"].fetch("location") { nil }
  profile.headline = auth["info"].fetch("headline") { nil }
  profile.industry = auth["info"].fetch("industry") { nil }
  profile.image = auth["info"].fetch("image") { nil }
  profile.public_profile_url = auth["info"]["urls"].fetch("public_profile") { nil }
  profile.educations = auth["extra"]["raw_info"]["educations"].fetch("values") {nil}
  profile.positions = auth["extra"]["raw_info"]["positions"].fetch("values") {nil}
  all_skills = []
  unless auth["extra"]["raw_info"]["skills"].blank?
    auth["extra"]["raw_info"]["skills"]["values"].each{|value| all_skills << value["skill"].fetch("name") {nil}}
  end

  profile.skills = all_skills
  profile.save!
 end

 def check_access_token(access_token, user_id)
  company_id = Company.find_by_access_token(access_token).id
  #create accesses
  Access.find_or_create_by(user_id: user_id, company_id: company_id, level: 1) unless company_id.nil?
  #2 denotes super user
 end


end



