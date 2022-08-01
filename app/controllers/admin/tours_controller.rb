class Admin::ToursController < ApplicationController
  layout "layouts/application_admin"
  before_action :logged_in_user
  before_action :check_admin
  before_action :load_tour, except: %i(create new index)

  def index
    @pagy, @tours = pagy(Tour.recent_tours, items: Settings.tour.per_page_admin)
  end

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new tour_params
    if @tour.save
      flash[:success] = t ".tours_create_successful"
      redirect_to admin_tours_path
    else
      flash.now[:danger] = t ".tours_not_saved"
      render :new
    end
  end

  def show
    @pagy, @reviews = pagy(@tour.reviews.most_recent,
                           items: Settings.review.admin_per_page)
  end

  def edit; end

  def update
    if @tour.update tour_params
      success_format t ".update_success"
    else
      danger_format t ".update_failed"
    end
  end

  def destroy
    total = Tour.all.count
    index = Tour.all.find_index(@tour)
    if @tour.destroy
      cur_page = handle_page total, index
      @pagy, @tours = pagy(Tour.recent_tours,
                           items: Settings.tour.per_page_admin, page: cur_page)
      success_format t ".destroy_success"
    else
      danger_format t ".destroy_danger"
    end
  end

  private

  def handle_page total, index
    cur_page = (((total - index) - 1) / Settings.tour.per_page_admin).ceil + 1

    tours = Tour.limit(Settings.tour.per_page_admin).offset(
      Settings.tour.per_page_admin * (cur_page - 1)
    )
    cur_page -= 1 if tours.empty?
    cur_page
  end

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    redirect_to admin_tours_path
  end

  def tour_params
    params.require(:tour).permit Tour::UPDATABLE_ATTRS
  end
end
