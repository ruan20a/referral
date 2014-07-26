class Authorization < ActiveRecord::Base
	belongs_to :user
	after_create :fetch_details



	def fetch_details
		self.send("fetch_details_from_#{self.provider.downcase}")
	end


	def fetch_details_from_facebook
		binding.pry
		graph = Koala::Facebook::API.new(self.token)
		binding.pry
		facebook_data = graph.get_object("me")
		binding.pry
		self.user = facebook_data['user']
		binding.pry
		self.save
		binding.pry
	end

	def fetch_details_from_github
	end


	def fetch_details_from_linkedin

	end
end