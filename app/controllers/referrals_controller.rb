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
   @ref_type = params[:ref_type]
   # @your_name = current_user.first_name && current_user.last_name || ""
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
      flash[:error] = "Please fill in all the required fields"
      redirect_to new_referral_path(:job_id => @referral.job_id, :ref_type => @referral.ref_type)
    end
	end

	def edit
	 @referral = Referral.find(params[:id])
	 @job = Job.find(@referral.job_id)
   @ref_type = @referral.ref_type
  end

	def show
    @referral = Referral.find(params[:id])
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
      params.require(:referral).permit(:name, :job_id, :referral_name, :referral_email, :relationship, :additional_details, :linked_profile_url, :status, :github_profile_url, :relevance, :user_id, :admin_id, :ref_type)
    end
end
