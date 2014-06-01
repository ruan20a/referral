# == Schema Information
#
# Table name: whitelists
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  is_admin   :boolean          default(FALSE)
#

class Whitelist < ActiveRecord::Base
	# has_many :users
	# has_many :admins

  #TODO to test.
  validates_presence_of :email, :uniqueness => {:case_sensitive => false}
end
