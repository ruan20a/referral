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
#  referral_id            :integer
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  tagline                :string(255)
#  linked_in              :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :validatable
  SOCIALS = {
    facebook: 'Facebook',
    github: 'Github',
    linkedin: 'Linkedin'
  }

    has_one :user_profile
    belongs_to :whitelist
    has_many :referrals
    has_many :authorizations
    has_many :jobs, :through => :referrals
    has_many :invitations
    validates :first_name, :last_name, :email, presence: true
    validates :email, :uniqueness => { :case_sensitive => false }

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

  def self.from_omniauth(auth, current_user)
    binding.pry
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      binding.pry
      user = current_user.nil? ? User.where("email = ?", auth["info"]["email"]).first : current_user
      if user.blank?
        binding.pry
        user = User.new
        user.create_user(auth, user)
      end
      binding.pry
     authorization.user_id = user.id
     authorization.save
   end
    authorization.user.create_profile(auth, authorization.user)
    authorization.user
 end

 def create_user(auth, user)
  user.password = Devise.friendly_token[0,10]
  user.first_name = auth.info.first_name
  user.last_name = auth.info.last_name
  user.email = auth.info.email
  user.save
  create_profile(auth, user)
 end

 def create_profile(auth, user)
  profile = UserProfile.find_or_initialize_by_user_id(user.id)
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
  auth["extra"]["raw_info"]["skills"]["values"].each{|value| all_skills << value["skill"].fetch("name") {nil}}
  profile.skills = all_skills
  profile.save!
 end


end



