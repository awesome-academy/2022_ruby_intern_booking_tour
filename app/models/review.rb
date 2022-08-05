class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  validates :rating, presence: true,
                     length: {maximum: Settings.review.rating_max,
                              minimum: Settings.review.rating_min}
  validates :content, presence: true,
  length: {maximum: Settings.review.content_max}

  scope :most_recent, ->{order(created_at: :desc)}
end
