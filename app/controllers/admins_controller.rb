class AdminsController < ApplicationController
before_filter :authenticate_admin!
def new
@admin = Admin.new
end

def index
	@jobs = Job.all
	@referrals = Referral.all
end
end
