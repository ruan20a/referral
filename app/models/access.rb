class Access < ActiveRecord::Base
  belongs_to :company
  belongs_to :user, :dependent => :destroy
  validates_presence_of :company_id, :user_id

end