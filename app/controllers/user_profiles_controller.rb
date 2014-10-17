class UserProfilesController < ApplicationController
   before_action :set_user_profile, only: [:show, :edit]

  def show
  	@user_profile
    end

  include ApplicationHelper

  def index
    @search = UserProfile.search(params[:q])
    @user_profiles = @search.result.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.json {render :json => @user_profiles}
    end
  end

  def show
    @user_profile
    @user = @user_profile.user
    # binding.pry
    @sent_referrals = Referral.sent_referrals(@user).count
    @pending = Referral.sent_referrals(@user).pending.count

    @interview = Referral.sent_referrals(@user).interview.count
    @completed = Referral.sent_referrals(@user).completed.count
    @successful = Referral.sent_referrals(@user).success.count

    @unreviewed_referrals = Referral.received_referrals(@user).unreviewed.count
    @received_referrals = Referral.received_referrals(@user).count
    @requested_referrals = Referral.requested_referrals(@user).count


    @inactive
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

