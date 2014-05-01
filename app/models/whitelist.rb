class Whitelist < ActiveRecord::Base
	has_many :users
	has_many :admins
end
