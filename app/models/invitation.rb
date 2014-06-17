class Invitation < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user_id
	before_create :check_user
	before_create :check_whitelist

	def set_user_id(current_user)
		self.user_id = current_user.id
	end

	def check_user
		raise ActiveRecord::Rollback if !User.find_by_email(self.invited_email).nil?		
	end

	def check_whitelist
		unless Whitelist.exists?(:email => self.invited_email)
    		Whitelist.create(:email => self.invited_email, :level => 1)
    	end
	end

	def record_success
		self.is_successful = true
		self.save
	end


end
