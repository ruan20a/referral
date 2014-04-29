class AdminsController < ApplicationController
before_filter :authenticate_admin!
def invite_admin
		@admin = Admin.invite!(:email => params[:admin][:email], :name => params[:admin][:name])
		render :json => @admin
	end
def index
	@jobs = Job.all
	@referrals = Referral.all
end
end
