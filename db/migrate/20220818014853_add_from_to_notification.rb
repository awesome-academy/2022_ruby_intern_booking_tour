class AddFromToNotification < ActiveRecord::Migration[6.1]
  def change
    add_reference :notifications, :tour_requests, null: true, foreign_key: true
  end
end
