class AdminBoardcastJob < ApplicationJob
  queue_as :default

  def perform data
    ActionCable.server.broadcast "admin_channel", {
      content: data[:data],
      type: data[:type],
      tour_request: data[:tour_request],
      notification: data[:notification]
    }
  end
end
