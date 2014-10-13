class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	skip_before_filter :authenticate_user!

	def all
		ipf_id = session[:ipf_id]
		# binding.pry
		p env["omniauth.auth"]
		access_token = params[:access_token]
		user = User.from_omniauth(env["omniauth.auth"], current_user, access_token, ipf_id)
		# binding.pry
		if user.persisted?
			# binding.pry
			flash[:notice] = "Welcome #{user.first_name}, you have successfully signed in."
			sign_in(user)
			redirect_to jobs_path
		else
			session["devise.user_attributes"] = user.attributes
			redirect_to new_user_registration_url
		end
	end

	  def failure
      #handle you logic here..
      #and delegate to super.
      super
   end


	#alias_method :facebook, :all
	alias_method :linkedin, :all
	#alias_method :github, :all

end