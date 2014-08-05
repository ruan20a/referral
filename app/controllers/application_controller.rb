class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :current_user

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :inviter_email, :password, :password_confirmation, :company, :first_name, :last_name, :industry, :image, :image_cache, :remote_image_url, :remove_image, :access_token) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :inviter_email, :password, :remember_me, :first_name, :last_name, :speciality_1, :speciality_2, :industry_1, :industry_2, :access_token) }
  end

  protected

  def store_location
    session[:return_to] = request.env['HTTP_REFERER']
  end

  #TODO figure out how to persist pending referrals



end
