module AdminsHelper
	def index
		@jobs = job.all
		@referrals =referral.all
	end

	def status_choices
	["Accepted", "Pending", "Approved"]
	end

	def relevance_choices
	["Relevant", "Not Relevant" ]
	end

#DEVISE
  def resource_name
    :admin
  end

  def resource
    @resource ||= Admin.new
  end

  def resource_path(id)
  	admin_path(id)
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:admin]
  end

  def devise_error_messages!
    resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
  end

end
