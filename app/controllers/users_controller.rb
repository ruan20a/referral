class UsersController < ApplicationController
  before_action :check_session
  before_action :set_user, only: [:show, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :store_location #enables linking back

  def show
    @user_email = @user.email

    #referrals recevied
    select_received = Referral.all.select{|referral| referral.referral_email == @user_email && referral.ref_type == "refer"}
    @received_referrals = select_received.paginate(page: params[:page], per_page: 10) if !select_received.nil?
    # binding.pry
    @unreviewed_referrals = @received_referrals.select{|referral| referral.is_interested == nil}
    @unreviewed_count = @unreviewed_referrals.count

    #my referrrals
    select_sent = @user.referrals.select{|referral| referral.ref_type == "refer"}
    @sent_referrals = select_sent.paginate(page: params[:page], per_page: 10)

    @hav_ref = has_any(@unreviewed_count)    #
  end

  def destroy
    if @user.destroy
      redirect_to new_user_registration_path, notice: "Account has been deleted."
    else
      render action: 'edit'
    end
  end

  protected

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :industry_1, :speciality_1, :referral_id, :profile_id, :tagline)
  end

  def check_session
    if current_user.nil? && current_admin.nil?
      flash[:notice] = "Please sign-in to continue."
      redirect_to new_user_session_path
    end
  end

  def correct_user
    user = User.find(params[:id])
    redirect_to new_user_session_path, :error => "You cannot view that account because you're not the correct admin. Please login to the correct account."  unless user == current_user
  end

  def has_any(var)
    var > 0 ? true : false
  end
end
