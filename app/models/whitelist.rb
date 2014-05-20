# == Schema Information
#
# Table name: whitelists
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Whitelist < ActiveRecord::Base
	has_many :users
	has_many :admins
end
