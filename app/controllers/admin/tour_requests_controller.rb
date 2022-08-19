class Admin::TourRequestsController < ApplicationController
  layout "layouts/application_admin"
  before_action :logged_in_user
  before_action :check_admin, only: %i(index update destroy)
  before_action :load_tour_requests, except: %i(index)
  before_action :check_reject, only: %i(destroy)

  def index
    @pagy, @tour_requests = pagy(TourRequest.lastest,
                                 items: Settings.tours_request.per_page_admin)
  end

  def destroy
    if @tour_request.rejected? && @tour_request.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_danger"
    end
    redirect_to admin_tour_requests_path
  end

  def show; end

  def update
    request_history = RequestHistory.find_by user_id: @tour_request.user_id,
                                             tour_id: @tour_request.tour_id
    check_request_history request_history
  end

  private
  def load_tour_requests
    @tour_request = TourRequest.find_by id: params[:id]
    return if @tour_request

    redirect_to admin_tour_requests_path
  end

  def check_reject
    return unless @tour_request.rejected?

    flash[:danger] = t ".reject"
    redirect_to admin_tour_requests_path
  end

  def check_request_history request_history
    case params[:sub]
    when "approve"
      @tour_request.approved!
      if request_history.present?
        request_history.approved!
      else
        create_history_request 1
      end
      success_format t ".approve_success"
    when "reject"
      @tour_request.rejected!
      if request_history.present?
        request_history.rejected!
      else
        create_history_request 2
      end
      success_format t ".reject_success"
    end
  end

  def create_history_request status
    RequestHistory.create_self @tour_request.user_id,
                               @tour_request.tour_id,
                               @tour_request.quantity,
                               @tour_request.tour_price,
                               status
  end
end
