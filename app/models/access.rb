# == Schema Information
#
# Table name: accesses
#
#  id         :integer          not null, primary key
#  company_id :integer
#  user_id    :integer
#  level      :integer          default(1)
#

class Access < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  validates_presence_of :company_id, :user_id
  validates_uniqueness_of :user_id, :scope => [:company_id]
  before_create :check_list
  before_create :turn_active


  def check_list
    redirect_to :back, notice: 'This email has not been approved. Please use assigned email. Email info@wekrut.com for any questions.' unless PrivateInvitation.exists?(email: self.user.email, company_id: self.company.id)
  end

  def turn_active #privateinvitation
    invitation = PrivateInvitation.find_by_email_and_company_id(self.user.email, self.company_id)
    invitation.update_attribute(:is_active,true)
  end


end
