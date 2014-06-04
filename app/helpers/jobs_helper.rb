module JobsHelper

  def industry_choices
    ["Financial Services", "Fashion", "Consumer", "Non-profit", "Advertising", "Professional Services", "Other"]
  end

  def admin_selection
    @admins = Admin.all
    @select_admins = []
    @admins.each do |admin|
      new_el = []
      full_name = admin.company + " - " + admin.first_name + " " + admin.last_name
      id = admin.id
      new_el << full_name
      new_el << id
      @select_admins << new_el
    end
    @select_admins
  end

  def find_company(admin_id)

  end

end
