module UsersHelper
	def industry_choices
		[:Technology , "Financial Services", :Fashion, "Professional Services"]
	end

	def speciality_choices
		[:Marketing, "Web Development", :Design]
	end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_path(id)
    user_path(id)
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def devise_error_messages!
    flash[:error] = resource.errors.full_messages.first
  end

end