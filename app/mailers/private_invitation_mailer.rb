class PrivateInvitationMailer < ActionMailer::Base
  default from: ENV['GMAIL']
  add_template_helper(ApplicationHelper)
  include ActionView::Helpers::NumberHelper

  def deliver_invite(invitee)
    @invitee = invitee
    @company = @invitee.company
    @company_link = "#{@company.access_token}"
    mail(to: @invitee.email, subject: "#{@invitee.first_name}'s Enterprise User Invite from #{@company.name} - WeKrut").deliver
  end

end
