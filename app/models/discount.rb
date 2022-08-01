class Discount < ApplicationRecord
  belongs_to :tour

  validates :discount_rate, :activated, presence: true
end
