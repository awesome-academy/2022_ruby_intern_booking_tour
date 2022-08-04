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
end
