class Admin::ToursController < ApplicationController
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
    @pagy, @reviews = pagy(@tour.reviews.recent_reviews,
                           items: Settings.review.admin_per_page)
  end

  def edit; end

  def update
    if @tour.update tour_params
      flash[:success] = t ".update_success"
      redirect_to admin_tours_path
    else
      flash.now[:danger] = t ".update_failed"
      render :edit
    end
  end

  def destroy
    if @tour.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_danger"
    end
    redirect_to admin_tours_path
  end

  def filter; end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:danger] = t ".show_tour_failed"
    redirect_to admin_tours_path
  end

  def tour_params
    params.require(:tour).permit Tour::UPDATABLE_ATTRS
  end

  def tour_filter_params
    params.require(:tours_filter).permit %i(start_date end_date price
avg_rating category_id name)
  end
end
