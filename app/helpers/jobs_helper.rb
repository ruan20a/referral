 module JobsHelper

  def industry_choices
    ["Financial Services", "Fashion", "Consumer", "Non-profit", "Advertising", "Professional Services", "Other"]
  end

  def correct_admin?(job)
    if job.company.admins.include?(current_admin) || main_admin?
      return true
    else
      return false
    end
  end

  def main_admin?
    return true if Whitelist.find_by_email(current_admin.email).level > 2
  end

  def admin_selection
    @admins = Admin.all
    @select_admins = []
    @admins.each do |admin|
      new_el = []
      full_name = admin.company.name + " - " + admin.first_name + " " + admin.last_name
      id = admin.id
      new_el << full_name
      new_el << id
      @select_admins << new_el
    end
    @select_admins
  end

  def active_choices
    [["Active", true],["Inactive", false]]
  end

  def public_choices
    [["Public", true],["Private", false]]
  end
end
