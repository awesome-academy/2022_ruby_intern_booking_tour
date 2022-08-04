class Tour < ApplicationRecord
  has_many :tour_requests, dependent: :destroy
  has_many :discounts, dependent: :destroy
  belongs_to :category

  has_one_attached :image

  validates :name, presence: true,
                        length: {maximum: Settings.tour.name_max}
  validates :description, presence: true,
                               length: {maximum: Settings.tour.description_max}
  validates :price, presence: true
  validates :avg_rating, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :image, content_type: {in: Settings.tour.image_type,
                                   message: :mess},
                    size: {
                      less_than: Settings.tour.image_size.megabytes,
                      message: :size_img
                    }

  scope :incre_order, ->{order(id: :asc)}
  scope :order_rating, ->(rating){where("avg_rating = ?", rating)}
end
