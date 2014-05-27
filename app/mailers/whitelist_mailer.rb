class WhitelistMailer < ActionMailer::Base
  default from: ENV['GMAIL']

  def deliver_confirmation(email, status)
    @email = email
    @status = status
    mail(to: @email, subject: "WeKrüt Email Approval").deliver
  end
end