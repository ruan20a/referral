class PrivateInvitation < ActiveRecord::Base
  belongs_to :company
  validates_uniqueness_of :email, :scope => [:company_id]
  validates_presence_of :company_id, :email, :first_name, :last_name
  before_create :send_email_notification
  scope :inactive, -> {where(is_active: false)}
  scope :private_company, lambda {|company| where('private_invitations.company_id = ?', company.id)}

  def map_company(company)
    self.map_company = company.id
  end

  def send_email_notification
    invitee = self
    PrivateInvitationMailer.deliver_invite(invitee)
  end

end