class UserProfilesController < ApplicationController


  def show
  	@user_profile
    
  end

  	def edit
  	@user.profile 
  end
end
