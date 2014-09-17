  class JobsController < ApplicationController
  # before_action :signed_in? only:[:new, :edit, :update]
  before_action :authenticate_admin!, only: [:new, :edit, :update, :create, :delete]
  before_action :check_level, only:[:new, :create, :edit, :update, :private]
  before_action :check_admin, only: [:edit, :update, :delete]
  before_action :set_job, only: [:show, :update, :edit, :destroy]
  before_action :store_location #enables linking back
  before_action :user_pending_received_requests, only: [:index]
  before_action :check_signed_in, only: [:edit, :delete, :update, :create, :private]
  # before_action :check_enterprise_access, only: [:new, :edit]
  # before_action :check_main_admin, only: [:edit, :update]
  # before_action :clear_search_index, :only => [:index]

  include ApplicationHelper

  #TODO move some variables to the model
	def invite_user
		@user = User.invite!(:email => params[:user][:email], :name => params[:user][:name])
		render :json => @user
	end

  def private
    # @all_jobs.each do |job|
      # if !current_user.nil? #users
        # @search = Job.selected_user(current_user).search(params[:q])
        # @jobs = @search.result.select{|x| x.is_active == true}.paginate(:page => params[:page])
        # access = Access.exists?(user_id: current_user.id, company_id: job.company_id)
        # @jobs << job unless access.nil?
      # elsif !@main_status # admin (dont have main status)
        # @search = Job.enterprise_admin(current_admin).search(params[:q])
        # @jobs = @search.result.select{|x| x.is_active == true}.paginate(:page => params[:page])
        # @jobs << job if current_admin.company == job.company
      # else #main_admin
        # @search = Job.private.search(params[:q])
        # @jobs = @search.result.select{|x| x.is_active == true}.paginate(:page => params[:page])
        # @jobs << job
      # end
    # end

    @all_jobs = Job.private
    @jobs = []

    @all_jobs.each do |job|
      if !current_user.nil? #users
        access = Access.exists?(user_id: current_user.id, company_id: job.company_id)
        @jobs << job unless access.nil?
      elsif !@main_status # admin
        @jobs << job if current_admin.company == job.company
      else #main_admin
        @jobs << job
      end
    end
  end



  def index
    @search = Job.public.search(params[:q]) #can chain with inactive
    @jobs = @search.result.select{|x| x.is_active == true}.paginate(:page => params[:page])

    @unreviewed_requests
    @has_ref = has_any(@unreviewed_requests)

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @jobs }
    end
  end

  def new
    @job = Job.new
    check_enterprise_access
  end

  def show
    @job
    @referral = Referral.new
    @ref_type = "refer"
    set_status(@job) #only for owner admin
  end

  def create
    #binding.pry
    @job = Job.new(job_params)
    set_admin(@job)
    #binding.pry
    if @job.save
      # binding.pry
      redirect_to @job, notice: 'Job was successfully created'
    else
      # binding.pry
      redirect_to :back, notice: 'There was an issue with your request'
    end
  end

  def edit
    @job
  end

  def update
    if @job.update(job_params)
      #binding.pry
      redirect_to @job, notice: 'Job successfully updated.'
    else
      render action: 'edit', notice: 'Please try again.'
    end
  end

  def destroy
    if @job.destroy
      redirect_to jobs_path, notice: 'Job successfully destroyed'
    else
      render action: 'edit', notice: 'We could not delele this job. Please try again.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def set_admin(job)
    if job.admin.nil?
      @admin = current_admin
    else
      @admin = job.admin
    end
    job.name = @admin.company.name
    job.company_id = @admin.company.id
  end

  def set_status(job)
    if job.admin == current_admin
      @status = true
    else
      @status = false
    end
  end

  def job_params
    params.require(:job).permit(:name, :job_name, :description, :city, :state, :admin_id, :referral_fee, :image, :image_cache, :remote_image_url, :remove_image,  :speciality_1, :speciality_2, :is_active, :industry_1, :company_id, :is_public, :min_salary, referrals_attributes: [:id])
	end

  def check_admin
    job = Job.find(params[:id])
    admin = Admin.find(job.admin_id)
    redirect_to job_path unless admin == current_admin || @level == 3
  end

  def search_params
    #
    params[:q]
  end

  #TODO REFACTOR!!
  def user_pending_received_requests
    #TODO need to refactor code!!
    if !current_user.nil?
      user_email = current_user.email
      @unreviewed_requests = Referral.all.select{|referral| referral.referral_email == user_email && referral.ref_type == "refer" && referral.is_interested == nil}.count
    elsif !current_admin.nil?
      #admin referrals - is_interested = true & ref_type = refer.
      admin_referrals = current_admin.referrals.select{|referral| referral.ref_type == "refer" && referral.is_interested == true}
      @unreviewed_requests = admin_referrals.select{|referral| referral.status == "Pending"}.count
    else
      @unreviewed_requests = 0
    end
    @unreviewed_requests
  end


  def clear_search_index
    redirect_to request.path
  end

  def check_signed_in
    if !user_signed_in? && !admin_signed_in?
      redirect_to new_user_session_path, notice: "You need to sign up before viewing this job"
    end
  end

  # def check_main_admin
  #   @level = Whitelist.find_by_email(current_admin.email).level
  #   @main_status = true
  #   redirect_to new_admin_session_path, notice: "You are not an approved admin" if @level != 3
  # end

  def check_level

    check_enterprise_access

    # check_enterprise_access

    unless current_admin.nil?
      @level = Whitelist.find_by_email(current_admin.email).level  #modified for private method
      if @level > 2
        @main_status = true
      end
    end
  end

  def check_enterprise_access
    if current_admin.company.level == 2
      @enterprise = true
    else
      @enterprise = false
    end
  end

end
