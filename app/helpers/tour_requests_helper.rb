module TourRequestsHelper
  def render_badge tour_request
    if tour_request.pending?
      class_name = "badge_details__pending"
      i18n_title = ".badge__pending"
    elsif tour_request.approved?
      class_name = "badge_details__success"
      i18n_title = ".badge__approve"
    else
      class_name = "badge_details__danger"
      i18n_title = ".badge__rejected"
    end
    "<div class='badge_details #{class_name}'>#{t(i18n_title)}</div>"
  end

  def render_badge_tbl tour_request
    if tour_request.pending?
      class_name = "badge-warning"
      i18n_title = ".badge__pending"
    elsif tour_request.approved?
      class_name = "badge-success"
      i18n_title = ".badge__approve"
    else
      class_name = "badge-danger"
      i18n_title = ".badge__rejected"
    end
    "<span class='badge #{class_name} badge_request_tbl_#{tour_request.id}'>
    #{t(i18n_title)}</span>"
  end
end
