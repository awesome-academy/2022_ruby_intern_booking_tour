module ToursHelper
  def render_star star
    temp = ""
    stared = star.to_i
    stared.times do
      temp += '<i class="iconify icon-star-full"
              data-icon="icomoon-free:star-full"></i>'
    end

    (Settings.tour.rating_max - stared).times do
      temp += '<i class="iconify icon-star-empty"
              data-icon="icomoon-free:star-empty"></i>'
    end
    temp
  end

  def date_diff start_date, end_date
    (end_date.to_date - start_date.to_date).to_i
  end

  def render_star_form
    temp = ""
    Settings.review.rating_max.downto(1) do |i|
      temp += "<i class='iconify icon-star-empty-form'
              data-icon='icomoon-free:star-empty' data-star='#{i}'></i>"
    end
    temp
  end

  def check_view_edit tour
    return unless tour.start_date >= Time.current

    link_to "<i class='nc-icon nc-ruler-pencil text-success m-2'></i>",
            edit_admin_tour_path(tour.id)
  end
end
