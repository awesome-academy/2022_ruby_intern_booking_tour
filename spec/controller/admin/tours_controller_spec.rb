RSpec.describe Admin::ToursController, type: :controller do
  let(:admin){
    FactoryBot.create :admin
  }

  let(:category) {
    FactoryBot.create :category
  }

  let(:tour_1){
    FactoryBot.create :tour_example_1, category_id: category.id
  }

  let(:tour_2){
    FactoryBot.create :tour_example_2, category_id: category.id
  }

  before :each do
    log_in admin
  end

  describe "GET admin/tours#index" do
    before do
      get :index
    end
    it "should assign @tours" do
      expect(assigns(:tours)).to eq([tour_2, tour_1])
    end

    it "should render the index template" do
      expect(response).to render_template("index")
    end
  end

  describe "When Create new tour" do
    it "should render new tour template" do
      get :new
      expect(response).to render_template("new")
    end

    context "when create tour successfull" do
      before do
        post :create, params: {
          tour: {
            name: "Name Tour1",
            description: "abc",
            start_date: Time.zone.parse('2022-09-11 21:00'),
            end_date: Time.zone.parse('2022-10-11 21:00'),
            price: 11,
            stock: 5,
            avg_rating: 1,
            category_id: category.id
          }
        }
      end

      it "should redirect to admin tours path" do
        expect(response).to redirect_to admin_tours_path
      end
    end

    context "when create tour failed with wrong value" do
      before do
        post :create, params: {
          tour: {
            name: "Name Tour2 ",
            description: "abc",
            start_date: Time.zone.parse('2022-10-11 21:00'),
            end_date: Time.zone.parse('2022-11-11 21:00'),
            category_id: category.id,
            price: 2,
            stock: -1,
            avg_rating: 1,
          }
        }
      end

      it "should display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.create.tours_not_saved")
      end

      it "should render to new admin tours path" do
        expect(response).to render_template :new
      end
    end
  end

  describe "Show tour" do
    context "When tour is not found" do
      before do
        get :show, params:{
          id: -1
        }
      end
      it "should display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.show.show_tour_failed")
      end
    end

    context "When tour is found" do
      before do
        get :show, params:{
          id: tour_1.id
        }
      end
      it "should tour display success" do
        expect(assigns(:tour)).to eq(tour_1)
      end
    end
  end

  describe "Edit tour" do
    context "When render edit tour success" do
      before do
        get :edit, params: {
          id: tour_1
        }
      end

      it " should display success flash" do
        expect(flash[:success]).to eq I18n.t("admin.tours.edit.edit_success")
      end
    end

    context "when render edit tour failed" do
      before do
        get :edit, params: {
          id: tour_2
        }
      end

      it "should display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.edit.edit_failed")
      end
    end

    context "when tour is not correct" do
      before do
        get :edit, params: {
          id: -1
        }
      end
      it "should display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.show.show_tour_failed")
      end
    end
  end

  describe "update tour" do
    context "when Success with valid attribute" do
      before do
        patch :update, xhr: true, params: {
          id: tour_1.id,
          tour: {name: "Change Name"}
        }
        tour_1.reload
      end

      it "should update db success" do
        expect([tour_1.name]).to eq(["Change Name"])
      end

      it "should render update" do
        expect(response).to render_template :update
      end
    end

    context "when Failed with invalid attribute" do
      before do
        patch :update, xhr: true, params: {
          id: tour_1.id,
          tour: {abc: "Change Name"}
        }
        tour_1.reload
      end

      it "should update db failed" do
        expect([tour_1.name]).to eq(["Name Tour1 "])
      end

      it "should render update" do
        expect(response).to render_template :update
      end
    end

    context "when Failed when tour is not correct" do
      before do
        patch :update, xhr: true, params: {
          id: 99999,
          tour: {name: "Change Name"}
        }
      end

      it "should display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.show.show_tour_failed")
      end
    end
  end

  describe "destroy tour" do
    context "when destroy tour failed" do
      before do
        delete :destroy, params: {
          id: -1
        }
      end

      it "should display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.show.show_tour_failed")
      end

      it "should render list tour ajax" do
        expect(response).to redirect_to admin_tours_path
      end
    end

    context "when destroy successfully" do
      before do
        delete :destroy, params: {
          id: 1
        }
      end

      it "should tour delete success" do
        expect(User.find_by id: 1).to eq(nil)
      end
    end
  end
end
