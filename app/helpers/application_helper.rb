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

end
