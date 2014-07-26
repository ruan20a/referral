class CompanyMailer < ActionMailer::Base
  default from: ENV['GMAIL']

  def deliver_company_request(user_name, user_email, recruiter_name, recruiter_email, company)
    @user_name = user_name
    @user_email = user_email
    @recruiter_name = recruiter_name
    @recruiter_email = recruiter_email
    @company = company
    mail(to: ENV['GMAIL'], subject: "Company Request from #{@company}").deliver
  end

end