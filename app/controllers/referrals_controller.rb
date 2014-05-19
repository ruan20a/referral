class ReferralsController < ApplicationController
  before_action :signed_in?

	def index
	  # @search = Referral.search(params[:q])
  	# @referrals = @search.result
    @referrals = Referral.all
    @jobs = Job.all
	end

	def new
   @referral = Referral.new
   @job = Job.find(params[:job_id])
	end

	def create
  	@referral = Referral.new(referral_params)

    if admin_signed_in?
      @referral.admin_id = current_admin.id
    else
      @referral.user_id = current_user.id
    end

  	if @referral.save
  	  redirect_to @referral
    else
      redirect_to new_referral_path
    end

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
      params.require(:referral).permit(:name, :job_id, :referral_name, :relationship, :additional_details, :linked_profile_url, :status, :github_profile_url, :relevance, :user_id, :admin_id)
    end
end
