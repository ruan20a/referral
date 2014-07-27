module ReferralsHelper
	def relationship_choices
		["Friend" , "Family", "Coworker", "Former Coworker", "Supervisor", "Former Supervisor", "Client", "Former Client"]
	end

	def status_choices
		["Pending","Pass","Interested", "Interview", "Interview - No Offer", "Interview - Offer" , "Offer Declined", "Succesful Placement"]
	end

	def relevance_choices
	  ["Relevant", "Not Relevant" ]
	end

  def is_interested_choices
    ["I'm interested in this role","I'm NOT interested in this role"]
  end

  def boolean
    [true, false]
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
