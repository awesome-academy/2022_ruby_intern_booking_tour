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
    if @tour_request.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_danger"
    end
    redirect_to admin_tour_requests_path
  end

  def show; end

  def update
    choice = params[:sub]
    case choice
    when "approve"
      @tour_request.approved!
      success_format t ".approve_success"
    when "reject"
      @tour_request.rejected!
      success_format t ".reject_success"
    else
      message = tour_request.errors.full_messages.to_sentence
      danger_format message.presence
    end
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
end
