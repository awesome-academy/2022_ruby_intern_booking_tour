class Notification < ApplicationRecord
  enum status: {read: 1, unread: 0}
  belongs_to :user, optional: true

  scope :lastest, ->{order(created_at: :desc)}

  validates :content, presence: true

  def update_read_noti
    read! if unread?
  end
end
