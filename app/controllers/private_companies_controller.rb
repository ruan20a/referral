class PrivateInvitationsController < ApplicationController
  # before_create :check_access

  def new
    @invite = PrivateInvitation.new
  end

  def create
    @invite = PrivateInvitation.new(private_invite_params)
    @invite.company_id = @invite.map_company(current_admin.company)
  end

  private

  def job_params
    params.require(:private_invitation).permit(:first_name, :last_name, :email, :company_id)
  end

end