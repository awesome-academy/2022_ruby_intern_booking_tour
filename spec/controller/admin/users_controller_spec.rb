RSpec.describe Admin::UsersController, type: :controller do
  let(:admin){
    FactoryBot.create :admin
  }

  let(:user_1){
    FactoryBot.create :user_example1
  }

  let(:user_2){
    FactoryBot.create :user_example2
  }

  before :each do
    log_in admin
  end

  describe "GET admin/users#index" do
    before do
      get :index
    end

    it "assign @users" do
      expect(assigns(:users)).to eq([user_2, user_1, admin])
    end

    it "render the index template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET /edit" do
    context "when user not found" do
      before do
        get :edit, params: {
          id: -1
        }
      end
      it "should display flash warning " do
        expect(flash[:danger]).to eq I18n.t("admin.users.show.show_user_failed")
      end

      it "should redirect admin users page" do
        expect(response).to redirect_to admin_users_path
      end
    end

    context "when user is found" do
      before do
        get :edit, params: {
          id: user_1.id
        }
      end
      it "should display success flash" do
        expect(flash[:success]).to eq I18n.t("admin.users.show.show_user_success")
      end

      it "should get user successfully" do
        expect(assigns(:user)).to eq(user_1)
      end
    end
  end

  describe "POST /update" do
    context "when update valid attributes" do
      before do
        patch :update, xhr: true, params: {
          id: user_2.id,
          user: {name: "Change Name"}
        }
        user_2.reload
      end

      it "should update db success" do
        expect([user_2.name]).to eq(["Change Name"])
      end
    end

    context "failed when update invalid attributes" do
      before do
        patch :update, xhr: true, params: {
          id: user_2.id,
          user: {abc: "Change Name"}
        }
        user_2.reload
      end


      it "should not update db success" do
        expect(user_2).not_to have_field('abc')
      end

      it "should update failed" do
        expect(response).to render_template :update
      end
    end

    context "failed when user is not correct" do
      before do
        patch :update, xhr: true, params: {
          id: 99999,
          user: {name: "Change Name"}
        }
      end

      it "should display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.users.show.show_user_failed")
      end
    end
  end
end
