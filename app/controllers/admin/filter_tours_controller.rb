class Admin::FilterToursController < ApplicationController
  layout "layouts/application_admin"
  before_action :logged_in_user
  before_action :check_admin

  def index
    order_by = check_order_by
    list_tours order_by[:order_name], order_by[:order_price]

    @pagy, @tours = pagy(@tours, items: Settings.tour.per_page_admin,
                          link_extra: 'data-remote="true"')

    respond_to do |format|
      format.js do
        render "admin/tours/filter_tour"
      end
    end
  end

  def check_order_by
    case params[:order_tours_admin]
    when Settings.admin.tour.name.desc
      order_name = "desc"
    when Settings.admin.tour.name.asc
      order_name = "asc"
    when Settings.admin.tour.price.desc
      order_price = "desc"
    when Settings.admin.tour.price.asc
      order_price = "asc"
    end

    {
      order_name: order_name, order_price: order_price
    }
  end

  def list_tours order_name, order_price
    start_date = params[:start_date]
    end_date = params[:end_date]
    start_price = params[:start_price]
    end_price = params[:end_price]
    avg_rating = params[:avg_ratings]
    name_like = params[:name_like]
    @tours = Tour.search start_date, end_date, start_price, end_price,
                         avg_rating, name_like, order_name, order_price
  end
end
