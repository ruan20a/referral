class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_one :profile
    belongs_to :whitelist
    has_many :referrals
    has_many :jobs, :through => :referrals
end
