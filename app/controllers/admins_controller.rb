class AdminsController < ApplicationController
before_filter :authenticate_user!
def index
	@jobs = Job.all
	@referrals = Referral.all
end
end
