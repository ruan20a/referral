class ReferralsController < ApplicationController
	def index
		@referrals = Referral.all
		@jobs = Job.all
	end
	def new
	@referral = Referral.find_by_id(params[:id])
	end

	def create
  	@referral = Referral.new(referral_params)
 
	end

	def show
    @referral = Referral.find_by_id(params[:id])
  	end
 
	private
  	def referral_params
      params.permit(:name, :referral_name, :relationship, :additional_details, :linked_profile_url, :referral_ids => [])
    end
end
