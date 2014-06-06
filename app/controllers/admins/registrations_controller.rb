class Admins::RegistrationsController < Devise::RegistrationsController

include AdminsHelper

  def create
    email = params[:admin][:email].downcase
    unless Whitelist.exists?(:email => email, :level => 2)
      email = params[:admin][:email]
      flash[:alert] = "#{email} is currently not on our beta list yet. Sign up #{view_context.link_to('here', root_path)} for our beta version.".html_safe
      redirect_to new_admin_registration_path
    else
      resource = build_resource(sign_up_params)
      if resource.save
        yield resource if block_given?
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          redirect_to resource_path(resource.id)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          redirect_to new_admin_session_path
        end
      else
        clean_up_passwords resource
        respond_with resource
      end
    end
    # unless Whitelist.exists?(:email => params[:user][:email])
    # else
    #   super
    # end
  end

end
