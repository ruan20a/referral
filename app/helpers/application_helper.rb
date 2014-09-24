module ApplicationHelper

  def has_any(var)
    var > 0 ? true : false
  end

  def pageless(total_pages, url=nil, container=nil)
    opts = {
        :totalPages => total_pages,
        :url        => url,
        :loaderMsg  => 'Loading more pages...',
        :loaderImage => image_path('load.gif')
    }

    container && opts[:container] ||= container

    javascript_tag("$('#results').pageless(#{opts.to_json});")
  end

  def calculate_fee(referral_fee)
    referral_fee = referral_fee/2
  end

  def replace_line_br(description)
    description.gsub(/\n/, '<br/>').html_safe
  end

  def state_choices
    ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky",
            "Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri",
            "Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Dakota",
            "North Carolina","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina",
            "South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
  end

  def sanitize_location(name)
    name.sub!(/,\s\w*$/,"")
  end

end
