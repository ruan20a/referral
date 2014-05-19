class JobsController < ApplicationController
	before_action :signed_in?
  before_action :authenticate_admin!, only: [:new, :edit, :update, :delete]
  before_action :check_admin, only: [:edit, :update, :delete]
  before_action :set_job, only: [:show, :update, :edit, :destroy]

	def invite_user
		@user = User.invite!(:email => params[:user][:email], :name => params[:user][:name])
		render :json => @user
	end

	def index
    # binding.pry
  	@search = Job.search(params[:id])
  	@jobs = @search.result
	end


	def new
	 @job = Job.new
   @job.admin_id = current_admin.id
	end


  def show
    @job = Job.find(params[:id])
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

	private
  def set_job
    @job = Job.find(params[:id])
  end

	def job_params
    params.require(:job).permit(:name, :job_name, :description, :city, :state, :admin_id, :referral_fee, :image, :speciality_1, :speciality_2, referrals_attributes: [:id])
	end

  def check_admin
    job = Job.find(params[:id])
    admin = Admin.find(job.admin_id)
    redirect_to job_path unless admin = current_admin
  end

end
