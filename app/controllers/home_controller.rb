class HomeController < ApplicationController
  def index
  end

  #beta request email
  def send_request
    name = params[:name]
    email = params[:email]
    linked_in = params[:linked_in]
    binding.pry

    if [name, email, linked_in].select{|x| x==""}.empty?
      BetaMailer.deliver_beta_request(name,email,linked_in)
      redirect_to root_path, notice: 'Your request has been sent!'
    else
      redirect_to root_path, notice: 'Request was not sent because there were missing fields. Please fill in all fields'
    end
  end

end
