module ReferralsHelper
	def relationship_choices
		["Friend" , "Coworker", "Family", "Client"]
	end

	def status_choices
		["Pending","Pass","Interview", "Interview - No Offer", "Interview - Offer" , "Offer Declined", "Succesful Placement"]
	end

	def relevance_choices
	  ["Relevant", "Not Relevant" ]
	end

  def translate_boolean(status)
    case status
    when true
      "Yes"
    when false
      "No"
    when nil
      "N/A"
    end
  end

end
