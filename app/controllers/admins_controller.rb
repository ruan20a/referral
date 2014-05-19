class AdminsController < ApplicationController
before_action :authenticate_admin!, only: [:show, :index]
before_action :set_admin, only: [:show, :update, :destroy]

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

private

def set_admin
    @admin = Admin.find(params[:id])
  end


def admin_params
  params.require(:admin).permit(:name, :email, :password, :password_confirmation, :remember_me, :encrypted_password)
end

def verify_current_admin
  if current_admin.nil?
    redirect_to new_admin_session_path, notice: 'Please sign-in as the correct admin to view this page'
  end
end

  def correct_admin
    admin= Admin.find(params[:id])
    redirect_to login_path, notice: "You cannot view this snippet because you're not the correct owner. Please login to the correct account." unless snippet.user == current_user
  end



end
