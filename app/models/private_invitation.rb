class PrivateInvitation < ActiveRecord::Base
  belongs_to :company
  validates_presence_of :company_id, :email, :first_name, :last_name

  def map_company(company)
    self.map_company = company.id
  end

end