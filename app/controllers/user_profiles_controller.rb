class UserProfilesController < ApplicationController



  def show
  	@user_profile
    
  before_action :set_user_profile, only: [:show, :edit]

  def index
    @user_profiles = UserProfile.all
  end

  def show
    @user_profile
  end

  def edit
    @user_profile
  end

  private

  def set_user_profile
    @user_profile = UserProfile.find(params[:id])
  end

  def user_profile_params
    params.require(:user_profile).permit(:email, :first_name, :last_name, :headline, :industry, :image, :public_profile_url, :location, :skills, :positions, :educations)
  end
  # def edit
  # 	@user.profile
  # end
end
