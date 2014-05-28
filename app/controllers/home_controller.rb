class HomeController < ApplicationController
  def index
  end

  #beta request email
  def email_request
    name = params[:name] || nil
    email = params[:email] || nil
    linked_in = params[:linked_in] || nil

    if [name, email, linked_in].
      BetaMailer.deliver_beta_request(name,email,linked_in)
      redirect_to root_path, notice: 'Your request has been sent!'
    else
      redirect_to home_path, notice: 'Please fill in all fields'
    end
  end

end
