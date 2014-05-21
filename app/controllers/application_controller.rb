class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :company, :first_name, :last_name) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me, :first_name, :last_name, :speciality_1, :speciality_2, :industry_1, :industry_2) }
  end

end
