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
end
