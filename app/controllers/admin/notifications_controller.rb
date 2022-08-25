class Admin::NotificationsController < ApplicationController
  layout "layouts/application_admin"
  before_action :logged_in_user, :check_admin
  before_action :load_notification, only: %i(update)

  def index
    @notifications = Notification.lastest.limit(Settings.notifications.filter)
  end

  def update
    @notification.read! if @notification.unread?
  end

  def filter_ajax
    off_set_val = params[:page].to_i * Settings.notifications.filter
    return if offsetVal >= Notification.all.count

    notifications = Notification.lastest
                                .limit(Settings.notifications.filter)
                                .offset(off_set_val).to_json
    render json: {"data": notifications}
  end

  def load_notification
    @notification = Notification.find_by id: params[:id].to_i
    return if @notification

    flash[:danger] = t ".load_notifications"
  end
end
