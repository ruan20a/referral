class Users::RegistrationsController < Devise::RegistrationsController

include UsersHelper

  def create
    resource = build_resource(sign_up_params)
    # binding.pry
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        redirect_to resource_path(resource.id)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        redirect_to new_user_session_path
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
    # unless Whitelist.exists?(:email => params[:user][:email])
    # else
    #   super
    # end
  end

end
