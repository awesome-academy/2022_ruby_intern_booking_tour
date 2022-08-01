module TourRequestsHelper
  def render_badge tour_request
    if tour_request.pending?
      class_name = "badge__pending"
      i18n_title = ".badge__pending"
    elsif tour_request.approved?
      class_name = "badge__success"
      i18n_title = ".badge__approve"
    else
      class_name = "badge__danger"
      i18n_title = ".badge__rejected"
    end
    "<div class='badge #{class_name}'>#{t(i18n_title)}</div>"
  end
end
