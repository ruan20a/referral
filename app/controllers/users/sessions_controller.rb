class Users::SessionsController < Devise::SessionsController


include UsersHelper

def new
  self.resource = resource_class.new(sign_in_params)
  clean_up_passwords(resource)
  respond_with(resource, serialize_options(resource))
end

def create
  # binding.pry
  access_token = params[:access_token]
  # binding.pry
  resource = warden.authenticate!(auth_options)
  user_id = resource.id
  # binding.pry
  resource.check_access_token(access_token, user_id) unless access_token.nil?
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