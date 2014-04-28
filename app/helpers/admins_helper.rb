module AdminsHelper
	def index
		@jobs = job.all
		@referrals =referral.all
	end
	
	def status_choices
	["Accepted", "Pending", "Approved"]
	end
end
