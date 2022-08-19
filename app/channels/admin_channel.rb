class AdminChannel < ApplicationCable::Channel
  def subscribed
    stream_from "admin_channel" if current_user.admin?
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
