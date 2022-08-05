class TourRequestsController < ApplicationController
  before_action :find_tour, :check_stock_constraint, only: :create

  def create
    if TourRequest.create_tour_request current_user.id, tour_requests_params
      find_tour
      respond_to do |format|
        format.js{flash.now[:success] = t(".tour_request_success")}
      end
    else
      respond_to do |format|
        format.js{flash.now[:danger] = t(".tour_request_error")}
      end
    end
  end

  private
  def tour_requests_params
    params.require(:tour_request).permit TourRequest::UPDATABLE_ATTRS
  end

  def find_tour
    @tour = Tour.find_by id: tour_requests_params[:tour_id]
    return if @tour

    flash[:danger] = t ".can_not_find_tour"
    redirect_to root_path
  end

  def check_stock_constraint
    return unless tour_requests_params[:quantity].to_i > @tour.stock

    respond_to do |format|
      if format.js
        flash.now[:danger] = t(".quantity_higher_than_stock")
        render status: :ok
      end
    end
  end
end
