class HomeController < ApplicationController

  def index
  end

  #beta request email
  def send_request
    email = params[:email]
    linked_in = params[:linked_in]

    if [name, email, linked_in].select{|x| x==""}.empty?
      binding.pry
      BetaMailer.deliver_beta_request(name,email,linked_in)
      redirect_to root_path, notice: 'Your request has been sent!'
    else
      redirect_to root_path, error: 'Request was not sent because there were missing fields. Please fill in all fields'
    end
  end

end
