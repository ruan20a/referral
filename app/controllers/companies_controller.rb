class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :private]
  before_action :check_access, only: [:edit, :update, :destroy, :private]
  before_action :redirect_incorrect_admin, only: [:new, :create]
  # before_action :check_enterprise_access, only: [:enterprise]

  #TODO - search does not work
  def private
    @invited_list
    # @search = User.private_company(@company).search(params[:q])
    @active_users = User.private_company(@company).paginate(:page => params[:page])
    @invited_users = PrivateInvitation.inactive.private_company(@company).paginate(:page => params[:page])
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @company }
    end
  end

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    # binding.pry
    if @company.save
      # binding.pry
      redirect_to @company, notice: 'Job was successfully created'
    else
      # binding.pry
      redirect_to :new, notice: 'Please complete required fields'
    end
  end

  def show
    @company
    @jobs = @company.jobs

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @company }
    end
  end

  def edit
    @company
  end

  def update
    if @company.update(company_params)
      #binding.pry
      redirect_to @company, notice: 'Company successfully updated.'
    else
      render action: 'edit', notice: 'Please try again.'
    end
  end

  def destroy
    if @company.destroy
      redirect_to companies_path, notice: 'Company successfully destroyed'
    else
      render action: 'edit', notice: 'We could not delele this company. Please try again.'
    end
  end


  #Method only allows super admins to go in
  private
  def set_company
      @company = Company.find(params[:id])
  end

  def check_access #all admins can edit their own profile
    unless current_admin.nil?
      if current_admin.company != @company
        redirect_incorrect_admin
      end
    else
      redirect_to new_admin_session_path, notice: "You need to be the assigned recruiter to edit the company profile."
    end
  end

  def check_enterprise_access #only enterprise admins won't be redirected
    redirect_to new_admin_session_path, notice: "You do not have enterprise access level." if current_admin.company.level == 1
  end

  def redirect_non_admin
    if current_admin.nil?
      redirect_to new_admin_session_path, notice: "You must be an approved administrator to create a new company listing."
    end
  end

  def redirect_incorrect_admin
    level = Whitelist.find_by_email(current_admin.email).level  #modified for private method
    if level < 3
      redirect_to new_admin_session_path, notice: "You must be an approved administrator to create a new company listing."
    end
  end

  def company_params
    params.require(:company).permit(:name, :address_line_1, :address_line_2, :city, :state, :country, :postal_code, :level, :description, :industry, :image, :image_cache, :remote_image_url, :remove_image)
  end
end