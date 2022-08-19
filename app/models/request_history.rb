class RequestHistory < ApplicationRecord
  enum status: {approved: 1, rejected: 2}

  belongs_to :user
  belongs_to :tour

  validates :quantity, :price, :status, presence: true

  scope :lastest, ->{order(created_at: :desc)}

  scope :select_statistic_col, (lambda do
                                  select(
                                    "COUNT(*) as count, users.email as email,
                                    tours.name as tour_name,
                                    request_histories.price as price,
                                    request_histories.quantity as quantity,
                                    sum(request_histories.price *
                                      request_histories.quantity)
                                    as total_price"
                                  )
                                end)

  scope :group_statistic_col, (lambda do
                                 group(
                                   "tours.id, tours.name,
                                    users.email,
                                    request_histories.price,
                                    request_histories.quantity,
                                    tours.start_date,
                                    tours.end_date,
                                      request_histories.created_at"
                                 )
                               end)

  scope :between_date_statistic, (lambda do |date|
    if date[:between].present?
      having(
        "request_histories.created_at >= '#{date[:start_date]}'
        AND request_histories.created_at <= '#{date[:end_date]}'"
      )
    end
  end)

  scope :after_date_statistic, (lambda do |date|
    if date[:after].present?
      having(
        "request_histories.created_at >= '#{date[:specific_date]}'"
      )
    end
  end)

  scope :before_date_statistic, (lambda do |date|
    if date[:before].present?
      having(
        "request_histories.created_at <= '#{date[:specific_date]}'"
      )
    end
  end)

  scope :specific_date_statistic, (lambda do |date|
    if date[:specific].present?
      having(
        "request_histories.created_at = '#{date[:specific_date]}'"
      )
    end
  end)

  scope :where_between_date_statistic, (lambda do |date|
    if date[:between].present?
      where(
        "created_at >= '#{date[:start_date]}'
        AND created_at <= '#{date[:end_date]}'"
      )
    end
  end)

  scope :where_after_date_statistic, (lambda do |date|
    if date[:after].present?
      where(
        "created_at >= '#{date[:specific_date]}'"
      )
    end
  end)

  scope :where_before_date_statistic, (lambda do |date|
    if date[:before].present?
      where(
        "created_at <= '#{date[:specific_date]}'"
      )
    end
  end)

  scope :where_specific_date_statistic, (lambda do |date|
    if date[:specific].present?
      where(
        "created_at = '#{date[:specific_date]}'"
      )
    end
  end)

  scope :sum_statistic, (lambda do
    select(
      "sum(request_histories.price * request_histories.quantity)
        as total"
    )
  end)

  def self.create_self user_id, tour_id, quantity, price, status
    request_history = RequestHistory.new
    request_history.user_id = user_id
    request_history.tour_id = tour_id
    request_history.quantity = quantity
    request_history.price = price
    request_history.status = status
    request_history.save!
  end

  def self.statistic_request_his
    @request_histories = RequestHistory.all.lastest.group(:price)
    @request_histories
  end

  def self.statistic_sum date
    RequestHistory
      .sum_statistic
      .where_between_date_statistic(date)
      .where_after_date_statistic(date)
      .where_before_date_statistic(date)
      .where_specific_date_statistic(date)
  end
end
