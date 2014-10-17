class HomeController < ApplicationController
  def index
    @company = Company.new
  end

  def private
    @access_token = params[:access_token]
    @company = Company.find_by_access_token(@access_token)
    redirect_to root_path, notice: 'Private site does not exists. Please check your URL or contact info@wekrut.com' if @company.nil?
    #flash[:error] not working?
  end

  #beta request email
  def send_request
    email = params[:email]
    linked_in = params[:linked_in]

    if [email, linked_in].select{|x| x==""}.empty?
      #binding.pry
      BetaMailer.deliver_beta_request(email,linked_in)
      redirect_to root_path, notice: 'Your request has been sent!'
    else
      redirect_to root_path, error: 'Request was not sent because there were missing fields. Please fill in all fields'
    end
  end

#company request email
    def send_company_request
    user_name = params[:user_name]
    user_email = params[:user_email]
    recruiter_name = params[:recruiter_name]
    recruiter_email = params[:recruiter_email]
    company = params[:company]

    if [user_name, user_email, recruiter_name, recruiter_email, company].select{|x| x==""}.empty?
      #binding.pry
      CompanyMailer.deliver_company_request(user_name, user_email, recruiter_name, recruiter_email, company)
      #binding.pry
      redirect_to root_path, notice: 'Your request has been sent!'
    else
      redirect_to root_path, error: 'Request was not sent because there were missing fields. Please fill in all fields'
    end
  end

end


