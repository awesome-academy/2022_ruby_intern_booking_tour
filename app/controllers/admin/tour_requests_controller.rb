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

  def show
    return if params[:notification_id].blank?

    notification = Notification.find_by id: params[:notification_id]
    notification.read! if notification.unread?
  end

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

  def check_request_history request_history
    case params[:sub]
    when "approve"
      update_approve_request request_history
    when "reject"
      update_reject_request request_history
    end
    flash.now[:success] = t(".socket_success")
  end

  def update_approve_request request_history
    @tour_request.approved!
    if request_history.present?
      request_history.approved!
    else
      create_history_request 1
    end
    content = "#{t('.sub_1')} #{@tour_request.tour.id}
                #{t('.sub_3')} #{@tour_request.user.email}"
    type = 1
    success_format t ".approve_success"
    send_notis content, @tour_request.user.id, type
  end

  def update_reject_request request_history
    @tour_request.rejected!
    if request_history.present?
      request_history.rejected!
    else
      create_history_request 2
    end
    content = "#{t('.sub_2')} #{@tour_request.tour.id}
                #{t('.sub_3')} #{@tour_request.user.email}"
    type = 2
    success_format t ".reject_success"
    send_notis content, @tour_request.user.id, type
  end

  def create_history_request status
    RequestHistory.create_self @tour_request.user_id,
                               @tour_request.tour_id,
                               @tour_request.quantity,
                               @tour_request.tour_price,
                               status
  end

  def send_notis data, user_id, type
    NotificationBoardcastJob.perform_later({
                                             data: data,
                                             user_id: user_id,
                                             type: type
                                           })
  end
end
