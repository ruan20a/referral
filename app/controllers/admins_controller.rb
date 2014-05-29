class AdminsController < ApplicationController
before_action :authenticate_admin!, only: [:show, :index]
before_action :set_admin, only: [:show, :update, :destroy]
before_action :correct_admin, only: [:show, :update, :edit, :destroy]
before_action :check_main_admin, only: [:index]
  def new
    @admin = Admin.new
  end

  def index
    @jobs = Job.all
    @referrals = Referral.select{|x| x.ref_type = "refer"}.paginate(page: params[:page], per_page: 10)
    @search = Referral.search(params[:q])
    #@referrals = @search.result
    @admins = Admin.new
  end

  def show
    @jobs = @admin.jobs
    @referrals = @admin.referrals.select{|x| x.ref_type == "refer" && x.is_interested == true}.paginate(page: params[:page], per_page: 10)
    #is_interested & pending status check
    @pending_referrals = @admin.referrals.select{|x| x.status == "pending" && x.is_interested == true}.count
  end

  def destroy
    @admin.destroy
    redirect_to new_admin_registration_path, notice: "You successfully deleted your account. We hope you will sign-up with us again"
  end

private

  def set_admin
      @admin = Admin.find(params[:id])
    end

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, :remember_me, :encrypted_password)
  end

  def correct_admin
    admin = Admin.find(params[:id])
    redirect_to new_admin_session_path, :error => "You cannot view that account because you're not the correct admin. Please login to the correct account." unless admin == current_admin
  end

    def check_main_admin
    #need to update this
      main_admins
      status = main_admins.select{|id| id == current_admin.email}
      redirect_to new_admin_session_path, error: "You are not an approved admin whitelister" if status.empty?
    end


end
