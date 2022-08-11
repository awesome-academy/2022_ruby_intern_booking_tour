class Tour < ApplicationRecord
  UPDATABLE_ATTRS = %i(name description price image start_date end_date
                       avg_rating category_id).freeze

  has_many :tour_requests, dependent: :destroy
  has_many :discounts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :category
  has_many :reviews, dependent: :destroy

  has_one_attached :image

  delegate :name, to: :category, prefix: true

  validates :name, presence: true,
                        length: {maximum: Settings.tour.name_max}
  validates :description, presence: true,
                               length: {maximum: Settings.tour.description_max}
  validates :start_date, :end_date, presence: true
  validates :price, presence: true,
                            numericality: {
                              greater_than_or_equal_to:
                               Settings.tour.quantity_min
                            }
  validates :stock, presence: true,
                            numericality: {
                              greater_than_or_equal_to:
                               Settings.tour.stock_min
                            }
  validates :avg_rating, presence: true,
                         numericality: {
                           greater_than_or_equal_to:
                           Settings.tour.rating_min,
                           smaller_than_or_equal_to:
                          Settings.tour.rating_max
                         }
  validates :image, content_type: {in: Settings.tour.image_type,
                                   message: :mess},
                    size: {
                      less_than: Settings.tour.image_size.megabytes,
                      message: :size_img
                    }

  scope :incre_order, ->{order(id: :asc)}
  scope :order_rating, ->(rating){where("avg_rating = ?", rating)}
  scope :recent_tours, ->{order(created_at: :desc)}
  scope :by_start_date, (lambda do |start_date|
    where("start_date >= ?", start_date) if start_date.present?
  end)
  scope :by_end_date, (lambda do |end_date|
    where("end_date >= ?", end_date) if end_date.present?
  end)
  scope :by_most_name, (lambda do |name|
    where("name LIKE ?", "%#{name}%") if name.present?
  end)
  scope :by_rating_array, (lambda do |get_rating|
    where(avg_rating: get_rating) if get_rating.present?
  end)

  def display_image
    image.variant resize_to_limit:
    [
      Settings.tour.height_limit,
      Settings.tour.width_limit
    ]
  end
end
