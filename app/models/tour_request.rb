class TourRequest < ApplicationRecord
  enum status: {pending: 0, approved: 1, rejected: 2}

  belongs_to :user
  belongs_to :tour

  validates :quantity, :total_price, :status, presence: true
end
