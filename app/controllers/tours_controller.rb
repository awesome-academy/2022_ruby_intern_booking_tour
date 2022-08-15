class ToursController < ApplicationController
  before_action :find_tour, :load_comments, only: :show
  before_action :gen_filter_rating, :filter_tour, only: :index

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

  def load_comments
    @pagy, @reviews = pagy @tour.reviews.most_recent,
                           items: Settings.review.review_per_page,
                           link_extra: 'data-remote="true"'
  end

  def gen_filter_rating
    @rating_filter = []
    (0..Settings.review.rating_max).each do |i|
      rating = params["rating_filter_#{i}"]
      @rating_filter[i] = rating if rating.present?
    end

    @rating_filter.map!.with_index do |x, i|
      i if x == "1"
    end
  end

  def filter_tour
    @pagy, @tours = pagy Tour.by_most_name(params.dig(:search, :name))
                             .by_start_date(params.dig(:search, :start_date))
                             .by_end_date(params.dig(:search, :end_date))
                             .by_rating_array(@rating_filter)
                             .recent_tours,
                         items: Settings.tour.tour_per_page,
                         link_extra: 'data-remote="true"'
  end
end
