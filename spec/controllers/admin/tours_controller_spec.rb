RSpec.describe Admin::ToursController, type: :controller do
  let(:admin){
    FactoryBot.create :admin
  }

  let(:category) {
    FactoryBot.create :category
  }

  let(:tour_1){
    FactoryBot.create :tour_example_1, category: category
  }

  let(:tour_2){
    FactoryBot.create :tour_example_2, category: category
  }

  before :each do
    log_in admin
  end

  describe "GET admin/tours#index" do
    it "assign @tours" do
      get :index
      expect(assigns(:tours)).to eq([tour_2, tour_1])
    end

    it "render the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "Create new tour" do
    it "render new tour template" do
      get :new
      expect(response).to render_template("new")
    end

    context "create tour successfull" do
      before do
        post :create, params: {
          tour: {
            name: "Name Tour demo ",
            description: "abc",
            start_date: Time.zone.parse('2022-09-11 21:00'),
            end_date: Time.zone.parse('2022-10-11 21:00'),
            category_id: category.id,
            price: 1123,
            stock: 100,
            avg_rating: 1
          }
        }
      end
      it "display success flash" do
        expect(flash[:success]).to eq I18n.t("admin.tours.create.tours_create_successful")
      end

      it "redirect to admin tours path" do
        expect(response).to redirect_to admin_tours_path
      end
    end

    context "create tour failed with invalid params" do
      before do
        post :create, params: {
          tour: {
            name: "Name Tour2 ",
            description: "abc",
            start_date: Time.zone.parse('2022-10-11 21:00'),
            end_date: Time.zone.parse('2022-11-11 21:00'),
            category_id: category.id,
            price: 2,
            stock: 1,
            avg_rating: 1,
            abc: "failed"
          }
        }
      end

      it "render to admin tours path" do
        expect(response).to redirect_to admin_tours_path
      end
    end

    context "create tour failed with wrong value" do
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

      it "display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.create.tours_not_saved")
      end

      it "render to new admin tours path" do
        expect(response).to redirect_to new_admin_tour_path
      end
    end
  end

  describe "Show tour" do
    context "When tour is not found" do
      before do
        get :show, params: {
          id: -1
        }
      end

      it "display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.show.show_tour_failed")
      end
    end
  end

  describe "Edit tour" do
    context "render edit tour success" do
      before do
        get :edit, params: {
          id: tour_1
        }
      end

      it "display success flash" do
        expect(flash[:success]).to eq I18n.t("admin.tours.edit.edit_success")
      end
    end

    context "render edit tour failed" do
      before do
        get :edit, params: {
          id: tour_2
        }
      end

      it "display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.edit.edit_failed")
      end
    end

    context "tour is not correct" do
      before do
        get :edit, params: {
          id: -1
        }
      end
      it "display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.show.show_tour_failed")
      end
    end
  end

  describe "update tour" do
    context "Success with valid attribute" do
      before do
        patch :update, xhr: true, params: {
          id: tour_1.id,
          tour: {name: "Change Name"}
        }
        tour_1.reload
      end

      it "update db success" do
        expect([tour_1.name]).to eq(["Change Name"])
      end

      it "render update" do
        expect(response).to render_template :update
      end
    end

    context "Failed with invalid attribute" do
      before do
        patch :update, xhr: true, params: {
          id: tour_1.id,
          tour: {abc: "Change Name"}
        }
        tour_1.reload
      end

      it "update db failed" do
        expect([tour_1.name]).to eq(["Name Tour1 "])
      end

      it "render update" do
        expect(response).to render_template :update
      end
    end

    context "Failed when tour is not correct" do
      before do
        patch :update, xhr: true, params: {
          id: 99999,
          tour: {name: "Change Name"}
        }
      end

      it "display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.show.show_tour_failed")
      end
    end
  end

  describe "destroy tour" do
    context "destroy tour failed" do
      before do
        delete :destroy, params: {
          id: -1
        }
      end

      it "display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.tours.show.show_tour_failed")
      end

      it "render list tour ajax" do
        expect(response).to redirect_to admin_tours_path
      end
    end
  end
end
