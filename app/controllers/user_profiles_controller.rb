class UserProfilesController < ApplicationController
  def show
  	user = current_user
	@user_profile = user.user_profile 
  end

  	def edit
  	@user.profile 
  end
end
