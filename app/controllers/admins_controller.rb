class AdminsController < ApplicationController
before_filter :authenticate_admin!
def index
	@jobs = Job.all
	@referrals = Referral.all
end
end
