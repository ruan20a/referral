class PrivateInvitationsController < ApplicationController
  before_action :redirect_incorrect_admin, only: [:index]
  before_action :set_private_invitation, only: [:destroy]
  # before_create :check_access

  def index
    @invite = PrivateInvitation.all
  end

  def new
    @private_invitation = PrivateInvitation.new
  end

  def create
    # binding.pry
    @private_invitation = PrivateInvitation.new(private_invitation_params)
    @private_invitation.map_company(current_admin.company)

    respond_to do |format|
      if @private_invitation.save
        format.html {redirect_to enterprise_company_path, notice: 'Invitation successfully sent'}
        format.json{render json:@private_invitation, status: :created}
      else
        format.html {redirect_to enterprise_company_path, notice: 'Email already exists.'}
        format.json {render json: @private_invitation.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    # binding.pry
    if @private_invitation.destroy
      redirect_to enterprise_company_path(current_admin.company.id), notice: 'Invitation Successfully Deleted. The user will not be able to sign up through the email link.'
    else
      redirect_to :back, notice: 'There was an issue with your removal.'
    end
  end

  private

  def set_private_invitation
    @private_invitation = PrivateInvitation.find(params[:private_invitation_id])
  end

  def private_invitation_params
    params.require(:private_invitation).permit(:email, :company_id)
  end

  def redirect_incorrect_admin
    level = Whitelist.find_by_email(current_admin.email).level  #modified for private method
    if level < 3
      redirect_to new_admin_session_path, notice: "You must be an approved administrator to create a new company listing."
    end
  end

end