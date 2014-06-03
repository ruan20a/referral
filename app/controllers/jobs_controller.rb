class JobsController < ApplicationController
	# before_action :signed_in? only:[:new, :edit, :update]
  before_action :authenticate_admin!, only: [:new, :edit, :update, :create, :delete]
  before_action :check_admin, only: [:edit, :update, :delete]
  before_action :set_job, only: [:show, :update, :edit, :destroy]
  before_action :store_location #enables linking back
  before_action :user_pending_received_requests, only: [:index]
  before_action :check_signed_in, only: [:show, :edit, :delete, :update, :create]
  before_action :check_level, only: [:new,:create, :edit, :update]
  # before_action :clear_search_index, :only => [:index]

  include ApplicationHelper

	def invite_user
		@user = User.invite!(:email => params[:user][:email], :name => params[:user][:name])
		render :json => @user
	end

  	def index
    # binding.pry

      # if @search.nil?
      #   @jobs = Job.all
      # else
          # @jobs = @search.result
      # end

      # @jobs = Job.all
      # @jobs.build_sort if @jobs.sorts.empty?
      # "s" => "job_name asc"

    # if !search_params["name_or_job_name_or_city_or_state_cont"].nil?
    #   @search = Job.search(search_params)
    #   @jobs = @search.result
    # end

    @search = Job.search(params[:q])
    @jobs = @search.result.paginate(:page => params[:page])
    @unreviewed_requests
    @has_ref = has_any(@unreviewed_requests)

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @jobs }
    end
	end


	def new
    @job = Job.new

  if level == 2
    @job.admin_id = current_admin.id
  end
	end

  def show
    @job
    @referral = Referral.new
    @ref_type = "refer"

    if @job.admin == current_admin
      @status = true
    else
      @status = false
    end
  end

  def create
    job = Job.new(job_params)
    job.admin_id = current_admin.id
    if job.save
      redirect_to job, notice: 'Job was successfully created'
    else
      render action: 'new'
    end
	end

  def edit
    @job.admin_id = current_admin.id
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @job.destroy
      redirect_to jobs_path, notice: 'Job successfully destroyed'
    else
      render action: 'edit'
    end
  end

	private

  def set_job
    @job = Job.find(params[:id])
  end

	def job_params
    params.require(:job).permit(:name, :job_name, :description, :city, :state, :admin_id, :referral_fee, :image, :image_cache, :remote_image_url, :remove_image,  :speciality_1, :speciality_2, :industry_1, referrals_attributes: [:id])
	end

  def check_admin
    job = Job.find(params[:id])
    admin = Admin.find(job.admin_id)
    redirect_to job_path unless admin == current_admin
  end

  def user_pending_received_requests
    #TODO need to refactor code!!
    if !current_user.nil?
      user_email = current_user.email
      @unreviewed_requests = Referral.all.select{|referral| referral.referral_email == user_email && referral.ref_type == "refer" && referral.is_interested == nil}.count
    elsif !current_admin.nil?
      #admin referrals - is_interested = true & ref_type = refer.
      admin_referrals = current_admin.referrals.select{|referral| referral.ref_type == "refer" && referral.is_interested == true}
      @unreviewed_requests = admin_referrals.select{|referral| referral.status == "pending"}.count
    else
      @unreviewed_requests = 0
    end
    @unreviewed_requests
  end

  def search_params
    params[:q]
  end

  def clear_search_index
    redirect_to request.path
  end

  def check_signed_in
    if !user_signed_in? && !admin_signed_in?
      redirect_to new_user_session_path, notice: "You need to sign up before viewing this job"
    end
  end

  def check_main_admin
    level = Whitelist.find_by_email(current_admin.email).level
    redirect_to new_admin_session_path, notice: "You are not an approved admin whitelister" if level != 3
  end

end
