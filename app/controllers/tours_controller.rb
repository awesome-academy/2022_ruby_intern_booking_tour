class ToursController < ApplicationController
  before_action :find_tour, :load_comments, only: :show
  before_action :filter_rating, :load_tours, only: :index

  def show; end

  def index
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def find_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:danger] = t ".can_not_find_tour"
    redirect_to root_path
  end

  def load_tours
    if @rating_filter.empty?
      @pagy, @tours = pagy Tour.recent_tours,
                           items: Settings.tour.tour_per_page,
                           link_extra: 'data-remote="true"'
    else
      filter_tour
    end
  end

  def load_comments
    @pagy, @reviews = pagy @tour.reviews.most_recent,
                           items: Settings.review.review_per_page,
                           link_extra: 'data-remote="true"'
  end

  def filter_tour
    get_rating = @rating_filter.map.with_index do |value, index|
      index if value == "1"
    end

    @pagy, @tours = pagy Tour.by_rating_array(get_rating).recent_tours,
                         items: Settings.tour.tour_per_page,
                         link_extra: 'data-remote="true"'
  end

  def filter_rating
    @rating_filter = []
    (0..Settings.review.rating_max).each do |i|
      rating = params["rating_filter_#{i}"]
      @rating_filter[i] = rating if rating.present?
    end
  end
end
