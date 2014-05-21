class ReferralsController < ApplicationController
  before_action :check_session
  before_action :set_referral, only: [:update, :edit, :destroy, :show]
  before_action :check_owner, only: [:update, :edit, :destroy]

  #TODO figure out if admin can make referrals as well

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
    @admin = @referral.job.admin

    #logic for admin/user
    if admin_signed_in?
      @referral.admin_id = current_admin.id
    else
      @referral.user_id = current_user.id
    end

    if @referral.save
      if @referral.ref_type == "refer"
        ReferralMailer.deliver_ref_email(@referral, @admin)
      else
        ReferralMailer.deliver_ask_email(@referral, current_user)
      end
      redirect_to @referral
    else
      flash[:error] = "Please fill in all the required fields"
      redirect_to new_referral_path(:job_id => @referral.job_id, :ref_type => @referral.ref_type)
    end
  end

  def edit
    @job = Job.find(@referral.job_id)
    @ref_type = @referral.ref_type
  end

  def show
    @referral
  end

  def update
    if @referral.update(referral.params)
      redirect_to @referral
    else
      render 'edit'
    end
  end

  def destroy
    @referral.destroy
  end

  protected

  def set_referral
    @referral = Referral.find(params[:id])
  end

  def referral_params
    params.require(:referral).permit(:name, :job_id, :referral_name, :referral_email, :relationship, :additional_details, :linked_profile_url, :status, :github_profile_url, :relevance, :user_id, :admin_id, :ref_type, :status)
  end

  #logic works for user/admin right now
  def check_owner
    referral = Referral.find(params[:id])
    if referral.user_id.nil?
      redirect_to(request.env["HTTP_REFERER"], notice: "You cannot modify this referral because you are not the owner") unless current_admin.id = referral.admin_id
    else
      redirect_to(request.env["HTTP_REFERER"], notice: "You cannot modify this referral because you are not the owner") unless current_user.id = referral.user_id
    end
  end

  def check_session
    if current_user.nil? && current_admin.nil?
      redirect_to(new_user_session_path, notice: "Please sign-in to make referrals")
    end
  end
end
