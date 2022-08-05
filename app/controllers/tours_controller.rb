class ToursController < ApplicationController
  before_action :find_tour, :load_comments, only: :show
  before_action :filter_tour, only: :index

  def show; end

  def index; end

  private

  def find_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:danger] = t ".can_not_find_tour"
    redirect_to root_path
  end

  def filter_tour
    @pagy, @tours = pagy Tour.incre_order,
                         items: Settings.tour.tour_per_page,
                         link_extra: 'data-remote="true"'

    return if params[:rating].blank?

    @pagy, @tours = pagy Tour.order_rating params[:rating],
                                           items: Settings.tour.tour_per_page
  end

  def load_comments
    @pagy, @reviews = pagy @tour.reviews.most_recent,
                           items: Settings.review.review_per_page,
                           link_extra: 'data-remote="true"'
  end
end
