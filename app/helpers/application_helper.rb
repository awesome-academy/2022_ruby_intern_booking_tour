module ApplicationHelper
  include Pagy::Frontend

  def pagy_url_for pagy, page, absolute: false, html_escaped: false
    params = request.query_parameters.merge(pagy.vars[:page_param] => page,
                                            only_path: !absolute)
    url = pagy_url_modify request.controller_class, request.request_method,
                          params
    return url if url

    html_escaped ? url_for(params).gsub("&", "&amp;") : url_for(params)
  end

  private

  def pagy_url_modify controller_class, request_method, params
    if (controller_class == TourRequestsController) &&
       (request_method == "DELETE")
      url_for(params).gsub(tour_request_path, tour_requests_path)
    elsif (controller_class == ReviewsController) && (request_method == "POST")
      url_for(params).gsub(reviews_path, request.referer)
    else
      false
    end
  end
end
