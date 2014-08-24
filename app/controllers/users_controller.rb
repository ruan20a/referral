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
    # binding.pry
# Kaminari.paginate_array(@arr_name).page
    #referrals recevied
    select_received = Referral.all.select{|referral| referral.referral_email == @user_email && referral.ref_type == "refer"}
    @received_referrals = select_received
    # .paginate(:page => params[:page]) if !select_received.nil?
    # binding.pry
    @unreviewed_referrals = @received_referrals.select{|referral| referral.is_interested == nil}
    @unreviewed_count = @unreviewed_referrals.count

    #my referrrals
    select_sent = @user.referrals.select{|referral| referral.ref_type == "refer"}
    @sent_referrals = select_sent
    # .paginate(:page => params[:page])

    select_ask = Referral.all.select{|referral| referral.referee_email == @user_email && referral.ref_type == "ask_refer"}
    @ask_referrals = select_ask
    # .paginate(:page => params[:page])
    @ask_referrals_count = select_ask.count

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
    params.require(:user).permit(:email, :password, :industry_1, :inviter_email, :speciality_1, :referral_id, :profile_id, :tagline)
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
