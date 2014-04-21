class Job < ActiveRecord::Base
	belongs_to :admin
	has_many :referrals
	has_many :users, :through => :referrals
end
