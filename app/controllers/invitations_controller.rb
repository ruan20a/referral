class InvitationsController < ApplicationController
	before_action :check_session
	before_action :check_level, only: [:index]


	def index
		@invitations = Invitation.all
	end

	def new
		@invitation = Invitation.new
	end

	def create
		invitation = Invitation.new(invitation_params)
		invitation.set_user_id(current_user)
		if invitation.save
			InvitationMailer.deliver_invitation(invitation)
			redirect_to jobs_path, notice: 'Invite Successfully Sent'
    	else
      		redirect_to new_invitation_path, notice: "Email #{invitation.invited_email} could not be added because it already exists"
    	end
	end

	
	protected

 	def check_session
    	if !user_signed_in? 
      	redirect_to user_session_path, notice: "You need to sign up before creating an invitation"
    	end
    end
 
    def check_level
    	if admin_signed_in?
    		@level = Whitelist.find_by_email(current_admin.email).level
    		redirect_to admin_session_path, notice: "Only approved admins can see this page" if @level < 3
    	else
    		redirect_to user_session_path, notice: "Only approved admins can see this page"
    	end
  	end

   	def invitation_params
    	params.require(:invitation).permit(:invited_email, :invited_name, :user_id, :is_successful)
	end
end
