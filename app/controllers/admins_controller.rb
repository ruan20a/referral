class AdminsController < ApplicationController
before_action :authenticate_admin!, only: [:show, :index]
before_action :set_admin, only: [:show, :update, :destroy]
before_action :correct_admin, only: [:show, :update, :edit, :destroy]

  def new
    @admin = Admin.new
  end

  def index
    @jobs = Job.all
    @referrals = Referral.all
  end

  def show
    @jobs = @admin.jobs
    @referrals = @admin.referrals
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
    redirect_to new_admin_session_path, :flash => { :error => "You cannot view that account because you're not the correct admin. Please login to the correct account." } unless admin == current_admin
  end


end
