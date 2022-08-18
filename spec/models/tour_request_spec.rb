require "rails_helper"

RSpec.describe "TourRequest", type: :model do
  describe "#position" do
    let(:tour_requests) {
      user = create(:user)
      tour_requests = create_list(:tour_request, 2, user: user)
      tour_requests.sort_by{|e| e[:created_at]}
    }
    it "should retun index postion" do
      expect(tour_requests[0].position).to eq(1)
    end
  end

  describe "#next" do
    let(:tour_requests) {
      user = create(:user)
      tour_requests = create_list(:tour_request, 2, user: user)
      tour_requests.sort_by{|e| e[:created_at]}
    }
    it "should next instance" do
      expect(tour_requests[0].next).to eq(tour_requests[1])
    end
  end

  describe "#modify_stock" do
    tour_stock = 5
    tour_request_quantity_old = 1
    tour_request_quantity_new = 2

    let (:tour) {
      tour = create(:tour, stock: tour_stock)
      tour_request = create(:tour_request, tour: tour,
                            quantity: tour_request_quantity_old)
      tour_stock -= tour_request_quantity_old
      tour_request.update(quantity: tour_request_quantity_new)
      tour
    }

    it "should return the valid stock" do
      expect(tour.stock).to eq(tour_stock + tour_request_quantity_old -
                               tour_request_quantity_new)
    end
  end

  describe "#add_stock" do
    tour_stock = 5
    tour_request_quantity = 2

    let(:tour) {
      tour = create(:tour, stock: tour_stock)
      tour_request = create(:tour_request, tour: tour,
                            quantity: tour_request_quantity)
      tour_stock -= tour_request_quantity
      tour_request.destroy
      tour_stock += tour_request_quantity
      tour
    }

    it "should return the valid stock" do
      expect(tour.stock).to eq(tour_stock)
    end
  end

  describe "#check_valid_date" do
    let(:tour_request) {
      tour = create(:tour, start_date: Time.zone.now - 60 * 60 * 60)
      build(:tour_request, tour: tour)
    }
    it "should check valid date of the tour" do
      expect(tour_request).to have(1).errors_on(:tour)
    end
  end

  describe "#check_status" do
    let(:tour_request) {
      tour_request = create(:tour_request, status: "approved")
      tour_request.try(:destroy)
    }
    it "should check valid status" do
      expect(tour_request).to eq(false)
    end
  end
end
