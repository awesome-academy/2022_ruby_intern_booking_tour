class NotificationBoardcastJob < ApplicationJob
  queue_as :default

  def perform data
    ActionCable.server.broadcast "notification_channel_#{data[:user_id]}",
                                 {content: data[:data], type: data[:type]}
  end
end
