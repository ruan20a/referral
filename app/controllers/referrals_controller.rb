class ReferralsController < ApplicationController
	def index
	@search = Referral.search(params[:q])
  	@referrals = @search.result
	end

	def update
		@referral = Referral.find_by_id(params[:id])
		@referral.update_attributes
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
      params.permit(:name, :referral_name, :relationship, :additional_details, :linked_profile_url, :status, :referral_ids => [])
    end
end
