class Users::RegistrationsController < Devise::RegistrationsController

include UsersHelper

  def create
    email = params[:user][:email].downcase

    unless Whitelist.exists?(:email => email)
      flash[:alert] = "#{email} is currently not on our beta list yet. Sign up #{view_context.link_to('here', root_path)} for our beta version.".html_safe
      redirect_to new_user_registration_path
    else
      resource = build_resource(sign_up_params)
      if resource.save
        yield resource if block_given?
        # if resource.active_for_authentication?
        # end
        if !params[:user][:inviter_email].blank?
          if User.exists?(:email => params[:user][:inviter_email].downcase)
            inviter_email = params[:user][:inviter_email].downcase
            inviter_id = User.find_by_email(inviter_email).id
            if Invitation.exists?(:user_id => inviter_id, :invited_email => email)
              invitation = Invitation.where(:user_id => inviter_id, :invited_email => email)[0]
              invitation.record_success
              InvitationMailer.send_successful_invitation(invitation)
            end
            set_flash_message :notice, :signed_up if is_flashing_format? #flash for successful inviter
          else
            flash[:notice] = "Account successfully created. Please note that we could not find the inviter email in our user database." #flash for bad inviter
          end
        else
          set_flash_message :notice, :signed_up if is_flashing_format? #flash for no inviter
        end
        sign_up(resource_name, resource)
        redirect_to jobs_path
        # else
        #   set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        #   expire_data_after_sign_in!
        #   redirect_to new_user_session_path
        # end
      else
        clean_up_passwords resource
        respond_with resource
      end
    end
  end

end
