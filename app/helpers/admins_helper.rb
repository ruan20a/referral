module AdminsHelper
	def index
		@jobs = job.all
		@referrals =referral.all
	end

	def relevance_choices
  	["Relevant", "Not Relevant" ]
	end

  def industry_choices
    ["Financial Services", "Fashion", "Consumer", "Non-profit", "Advertising", "Professional Services", "Other"]
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

  def company_selection
    @companies = Company.all
    @select_companies = [["Select Company", nil]]
    @companies.each do |company|
      new_el = []
      full_name = company.name
      id = company.id
      new_el << full_name
      new_el << id
      @select_companies << new_el
    end
    @select_companies
  end

end
