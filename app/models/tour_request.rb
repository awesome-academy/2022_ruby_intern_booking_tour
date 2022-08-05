class TourRequest < ApplicationRecord
  enum status: {pending: 0, approved: 1, rejected: 2}

  belongs_to :user
  belongs_to :tour

  UPDATABLE_ATTRS = %i(user_id tour_id quantity total_price).freeze

  validates :quantity, :total_price, :status, presence: true

  def self.create_tour_request user_id, tour_request_params
    tour_request = new(tour_request_params)
    tour_request.user_id = user_id
    tour = Tour.find_by id: tour_request_params[:tour_id]
    ActiveRecord::Base.transaction do
      tour_request.save!
      tour.update! stock: tour.stock - tour_request_params[:quantity].to_i
      true
    rescue StandardError
      false
    end
  end
end
