class Admins::SessionsController < Devise::SessionsController

include AdminsHelper

protected
  def after_sign_in_path_for(admin)
    resource_path(admin.id)
  end

end