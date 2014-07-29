class Users::SessionsController < Devise::SessionsController
	

include UsersHelper

def create
  resource = warden.authenticate!(auth_options)
  set_flash_message(:notice, :signed_in) if is_flashing_format?
  sign_in(resource_name, resource)
  yield resource if block_given?
  respond_with resource, location: after_sign_in_path_for(resource)
end

protected

  def after_sign_in_path_for(user)
    jobs_path
  end

end