class Admin::TourRequestsController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin, only: %i(index update destroy)
  before_action :load_tour_requests, except: %i(index)

  def index
    @pagy, @tour_requests = pagy(TourRequest.lastest,
                                 items: Settings.tours_request.per_page_admin)
  end

  def destroy
    if @tour_request.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_danger"
    end
    redirect_to admin_tour_requests_path
  end

  def update
    choice = params[:sub]
    if choice == "approve"
      @tour_request.approved!
    else
      @tour_request.rejected!
    end
    respond_to do |format|
      format.js
    end
  end

  def load_tour_requests
    @tour_request = TourRequest.find_by id: params[:id]
    return if @tour_request

    redirect_to admin_tour_requests_path
  end
end
