class Access < ActiveRecord::Base
  belongs_to :company_id
  belongs_to :user_id
  validates_presence_of :company_id, :user_id
end