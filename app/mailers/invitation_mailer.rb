class InvitationMailer < ActionMailer::Base
  default from: ENV['GMAIL']

  include ApplicationHelper

  def deliver_invitation(invitation)
  	@invited_email = invitation.invited_email
  	@invited_name = invitation.invited_name
  	@inviter_email = invitation.user.email
  	@inviter_FN = invitation.user.first_name
  	@inviter_LN = invitation.user.last_name
  	# binding.pry

  	mail(to: @invited_email,subject: "Invitation to join WeKrüt from #{@inviter_FN} #{@inviter_LN}", cc: @inviter_email).deliver
  end

  def send_successful_invitation(invitation)

  end

end