module ReviewsHelper
  def render_reviews_star star
    temp = ""
    stared = star.to_i
    stared.times do
      temp += '<button type="button" class="btn btn-warning btn-xs"
      aria-label="Left Align">
      <span class="iconify" data-icon="emojione:star"></span>
      </button>'
    end

    (Settings.tour.rating_max - stared).times do
      temp += '
      <button type="button" class="btn btn-default btn-grey btn-xs"
      aria-label="Left Align">
      <span class="iconify" data-icon="emojione:star"></span>
      </button>
      '
    end
    temp
  end
end
