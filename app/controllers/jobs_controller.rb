class JobsController < ApplicationController
	before_action :signed_in?
  before_action :authenticate_admin!, only: [:new, :edit, :update, :delete]
  before_action :set_admin_id, only: [:new]
  before_action :check_admin, only: [:edit, :update, :delete]

	def invite_user
		@user = User.invite!(:email => params[:user][:email], :name => params[:user][:name])
		render :json => @user
	end

	def index
    # binding.pry
  	@search = Job.search(params[:q])
  	@jobs = @search.result
	end


	def new
	 @job = Job.new
	end


  def show
    @job = Job.find(params[:id])
  end


  def create
  	@job = Job.new(job_params)
  	@job.save
  	redirect_to @job
	end

	private
	def job_params
    params.require(:job).permit(:name, :job_name, :description, :city, :state, :admin_id, :referral_fee, :image, :speciality_1, :speciality_2, referrals_attributes: [:id])
	end

  def set_admin_id
    @job.admin_id = current_admin.id
  end

  def check_admin
    job = Job.find(params[:id])
    admin = Admin.find(job.admin_id)
    redirect_to job_path unless admin = current_admin
  end

end
