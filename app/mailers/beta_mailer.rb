class BetaMailer < ActionMailer::Base
  default from: ENV['GMAIL']

  def deliver_beta_request(name, email, linked_in)
    @email = email
    @linked_in = linked_in
    mail(to: ENV['GMAIL'], subject: "Beta Request from #{@email}").deliver
  end

end