class StaticPagesController < ApplicationController
  before_action :filter_tour, only: :tour

  def home; end

  def tour; end

  private

  def filter_tour
    @pagy, @tours = pagy Tour.incre_order,
                         items: Settings.tour.tour_per_page

    return if params[:rating].blank?

    @pagy, @tours = pagy Tour.order_rating params[:rating],
                                           items: Settings.tour.tour_per_page
  end
end
