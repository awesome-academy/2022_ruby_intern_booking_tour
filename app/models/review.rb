class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  delegate :name, :email, to: :user, prefix: true
  validates :rating, presence: true
  validates :content, presence: true,
  length: {maximum: Settings.review.content_max}

  scope :most_recent, ->{order(created_at: :desc)}
  scope :recent_reviews, ->{order(created_at: :desc)}
end
