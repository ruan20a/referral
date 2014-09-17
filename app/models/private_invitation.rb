class PrivateInvitation < ActiveRecord::Base
  belongs_to :company
  before_create :send_email_notification
  scope :inactive, -> {where(is_active: false)}
  scope :private_company, lambda {|company| where('private_invitations.company_id = ?', company.id)}
  validates_uniqueness_of :email, :scope => :company_id, :case_sensitive => false
  validates_presence_of :company_id, :email

  def map_company(company)
    self.company_id = company.id
  end

  def send_email_notification
    invitee = self
    PrivateInvitationMailer.deliver_invite(invitee)
  end



end