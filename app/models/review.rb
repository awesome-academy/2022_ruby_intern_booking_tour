class Review < ApplicationRecord
  after_create :update_tour_rating

  belongs_to :user
  belongs_to :tour

  UPDATABLE_ATTRS = %i(user_id tour_id rating content).freeze

  delegate :name, :email, to: :user, prefix: true
  delegate :image, :avg_rating, :name, :price, :stock, :end_date, :start_date,
           :description, to: :tour, prefix: true

  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: Settings.review.rating_min,
    smaller_than_or_equal_to: Settings.review.rating_max
  }
  validates :content, presence: true,
  length: {maximum: Settings.review.content_max}

  scope :most_recent, ->{order(created_at: :desc)}

  private

  def update_tour_rating
    new_rating = (tour.avg_rating * (tour.reviews.size - 1) + rating).to_f
    tour.update! avg_rating: new_rating / tour.reviews.size
  end
end
