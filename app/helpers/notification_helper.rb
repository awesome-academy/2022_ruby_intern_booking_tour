module NotificationHelper
  def load_notifications
    @notifications = Notification.lastest.limit(5)
  end
end
