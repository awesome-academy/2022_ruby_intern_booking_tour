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
  scope :order_rating, (lambda do |rating|
    where("avg_rating = ?", rating)
  end)
  scope :recent_tours, ->{order(created_at: :desc)}
  scope :by_start_date, (lambda do |start_date|
    where("start_date >= ?", start_date) if start_date.present?
  end)
  scope :by_end_date, (lambda do |end_date|
    where("end_date <= ?", end_date) if end_date.present?
  end)
  scope :by_most_name, (lambda do |name|
    where("name LIKE ?", "%#{name}%") if name.present?
  end)
  scope :by_rating_array, (lambda do |get_rating|
    where(avg_rating: get_rating) if get_rating.present?
  end)

  scope :by_start_price, (lambda do |start_price|
    where("price >= ?", start_price) if start_price.present?
  end)

  scope :by_end_price, (lambda do |end_price|
    where("price <= ?", end_price) if end_price.present?
  end)

  scope :by_avg_ratings, (lambda do |avg_ratings|
    where("avg_rating <= ?", avg_ratings) if avg_ratings.present?
  end)

  scope :order_by_name, (lambda do |order_by|
    order(name: order_by) if order_by.present?
  end)

  scope :order_by_price, (lambda do |order_by|
    order(price: order_by) if order_by.present?
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

  def self.search start_date, end_date, start_price, end_price,
    avg_rating, name_like, order_name, order_price

    @tours = Tour.by_start_date(start_date)
                 .by_end_date(end_date)
                 .by_start_price(start_price)
                 .by_end_price(end_price)
                 .by_avg_ratings(avg_rating)
                 .by_most_name(name_like)
                 .order_by_price(order_price)
                 .order_by_name(order_name)
    @tours
  end
end
