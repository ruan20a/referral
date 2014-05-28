class UsersController < ApplicationController
  before_action :check_sessions
  before_action :set_user, only: [:show, :destroy]

  def show
    @user
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

end
