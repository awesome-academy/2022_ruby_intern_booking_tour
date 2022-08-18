require "rails_helper"

RSpec.describe TourRequestsController, type: :controller do
  let(:user) {
    create(:user, activated: true)
  }
  before {
    log_in user
  }

  describe "GET #index" do
    it "should get all tour request" do
      get :index
      expect(@controller.instance_variable_get(:@tour_requests)).should_not be_nil
    end
  end

  describe "POST #create" do
    let(:tour) {
      create(:tour)
    }
    it "should create new a tour request" do
      post :create, xhr: true, params: {tour_request: {quantity: 1,
                                                       total_price: 1,
                                                       tour_id: tour.id}}
      expect(TourRequest.count).to eq(1)
    end

    it "should fail in creating a tour request" do
      post :create, xhr: true, params: {tour_request: {quantity: -1,
                                                       total_price: -1,
                                                       tour_id: tour.id}}
      expect(TourRequest.count).to eq(0)
    end

    it "should fail in creating a tour request" do
      post :create, xhr: true, params: {tour_request: {quantity: 1,
                                                       total_price: 1,
                                                       tour_id: -1}}
      expect(TourRequest.count).to eq(0)
    end
  end

  describe "PATCH #update" do
    let(:tour) {
      create(:tour, stock: 3)
    }

    let(:tour_request) {
      create(:tour_request, user: user, tour: tour, quantity: 1)
    }
    it "should update the tour request successfully" do
      patch :update, xhr: true, params: {id: tour_request.id, tour_request: {quantity: 2,
                                                                             total_price: 2}}
      expect(@controller.instance_variable_get(:@tour_request).quantity).to eq(2)
    end

    it "should fail to update the tour request" do
      patch :update, xhr: true, params: {id: tour_request.id, tour_request: {quantity: -1,
                                                                             total_price: 2}}
      expect(@controller.instance_variable_get(:@tour_request).quantity).to eq(1)
    end
  end

  describe "DELETE #destroy" do
    let(:tour) {
      create(:tour, stock: 3)
    }

    let(:tour_request) {
      create(:tour_request, user: user, tour: tour, quantity: 1)
    }
    it "should delete the tour request successfully" do
      delete :destroy, xhr: true, params: {id: tour_request.id}
      expect(TourRequest.count).to eq(0)
    end

    it "should fail to delete the tour request" do
      tour_request.update_column(:status, "rejected")
      delete :destroy, xhr: true, params: {id: tour_request.id}
      expect(TourRequest.count).to eq(1)
    end

    it "should fail to find the tour request" do
      delete :destroy, xhr: true, params: {id: -1}
      expect(flash.instance_variable_get(:@flashes)["danger"]).should_not be_nil
    end
  end
end
