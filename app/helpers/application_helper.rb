module ApplicationHelper
  include Pagy::Frontend

  def pagy_url_for pagy, page, absolute: false, html_escaped: false
    params = request.query_parameters.merge(pagy.vars[:page_param] => page,
                                            only_path: !absolute)
    if (request.controller_class == TourRequestsController) &&
       (request.request_method == "DELETE")
      url_for(params).gsub(tour_request_path, tour_requests_path)
    else
      html_escaped ? url_for(params).gsub("&", "&amp;") : url_for(params)
    end
  end
end
