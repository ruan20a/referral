class UsersController < ApplicationController
  before_action :check_session
  before_action :set_user, only: [:show, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :store_location #enables linking back
  before_action :check_main_admin, only: [:index, :new ]

  include ApplicationHelper

  def index
   @users = User.all
  end

  def show
    @user_email = @user.email
# Kaminari.paginate_array(@arr_name).page
    #referrals recevied
    @received_referrals = Referral.received_referrals(@user)
    # .paginate(:page => params[:page]) if !select_received.nil?
    @unreviewed_referrals = Referral.received_referrals(@user).unreviewed
    @unreviewed_count = @unreviewed_referrals.count
    #my referrrals
    @sent_referrals = Referral.sent_referrals(@user)
    # .paginate(:page => params[:page])
    @ask_referrals = Referral.requested_referrals(@user)
    @ask_referrals_count = @ask_referrals.count
    @hav_ref = has_any(@unreviewed_count)
     #
  end

  def destroy
    if @user.destroy
      redirect_to user_omniauth_authorize_path, notice: "Account has been deleted."
    else
      render action: 'edit'
    end
  end

  protected

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :invited_by_ipf_id, :password, :industry_1, :inviter_email, :speciality_1, :referral_id, :profile_id, :tagline)
  end

  def check_session
    if current_user.nil? && current_admin.nil?
      flash[:notice] = "Please sign-in to continue."
      redirect_to user_omniauth_authorize_path
    end
  end

  def correct_user
    user = User.find(params[:id])

    if !current_admin.nil?
      level = Whitelist.find_by_email(current_admin.email).level
    end

    redirect_to new_user_session_path, :error => "You cannot view that account because you're not the correct admin. Please login to the correct account."  unless user == current_user || level == 3
  end

  def check_main_admin
    level = Whitelist.find_by_email(current_admin.email).level
    redirect_to new_admin_session_path, notice: "You are not an approved admin whitelister" if level != 3
  end



end


#only lets main admin see this page
  def check_main_admin
    level = Whitelist.find_by_email(current_admin.email).level
    redirect_to new_admin_session_path, notice: "You are not an approved admin whitelister" if level != 3
  end
