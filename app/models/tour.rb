class Tour < ApplicationRecord
  has_many :tour_requests, dependent: :destroy
  has_many :discounts, dependent: :destroy
  belongs_to :category

  has_one_attached :image

  validates :tour_name, presence: true,
                        length: {maximum: Settings.tour.name_max}
  validates :tour_description, presence: true,
                               length: {maximum: Settings.tour.description_max}
  validates :price, presence: true
  validates :avg_rating, presence: true,
                         length: {maximum: Settings.tour.rating_max,
                                  minimum: Settings.tour.rating_max}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :image, content_type: {in: Settings.tour.image_type,
                                   message: :mess},
                    size: {
                      less_than: Settings.tour.image_size.megabytes,
                      message: :size_img
                    }
end
