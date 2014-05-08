module ReferralsHelper
	def relationship_choices
		["Friend" , "Coworker", "Family"]
	end
	def status_choices
		["Interview Stage", "Offer Stage", "No Offer", "Successful Placement" ]
	end

	def relevance_choices
	["Relevant", "Not Relevant" ]
	end
end
