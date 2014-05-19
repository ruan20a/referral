class Users::SessionsController < Devise::SessionsController

include UsersHelper

protected
  def after_sign_in_path_for(user)
    resource_path(user.id)
  end

end