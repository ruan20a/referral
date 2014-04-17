class ReferralsController < ApplicationController
	def new
	@referral = Referral.find_by_id(params[:id])
	end

	def create
  	@referral = Referral.new(referral_params)
 
	end
 
	private
  	def referral_params
      params.permit(:name, :referral_name, :relationship, :additional_details, :linked_profile_url)
    end
end
