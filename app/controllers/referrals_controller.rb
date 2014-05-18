class ReferralsController < ApplicationController
	def index
	@search = Referral.search(params[:q])
  	@referrals = @search.result
	end

	def new
	@referral = Referral.new
	end

	def create
  	@referral = Referral.new(referral_params)

  	@referral.save
  	redirect_to @referral
 
	end

	def edit
		 @referral = Referral.find(params[:id])
		end

	def show
    @referral = Referral.find_by_id(params[:id])
  	end

  	def update
  		@referral = Referral.find(params[:id])

  		if @referral.update(referral.params)
  			redirect_to @referral
  		else
  			render 'edit'
		end
		end
	
	private
  	def referral_params
      params.require(:referral).permit(:name, :referral_name, :relationship, :additional_details, :linked_profile_url, :status, :github_profile_url)
    end
end
