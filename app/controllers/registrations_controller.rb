class RegistrationsController < Devise::RegistrationsController
  def create
    unless Whitelist.exists?(:email => params[:user][:email])
    else
      super  
    end
  end
end
