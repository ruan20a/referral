module UsersHelper
	def industry_choices
		["Financial Services", "Fashion", "Consumer", "Non-profit", "Advertising", "Professional Services", "Other"]
	end

	def speciality_choices
		["Marketing", "Web Development", "Design", "Administrative", "Operations", "Finance", "Business Development", "Account Management", "Other"]
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
    resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
  end

end