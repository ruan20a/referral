class AdminsController < ApplicationController
before_filter :authenticate_admin!
def new
@admin = Admin.new
end

def index
	@search = Referral.search(params[:q])
  	@referrals = @search.result
	@search = Job.search(params[:q])
  	@jobs = @search.result
end
end
