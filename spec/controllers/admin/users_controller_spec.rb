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
    it "assign @users" do
      get :index
      expect(assigns(:users)).to eq([user_2 ,user_1, admin])
    end

    it "render the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET /edit" do
    context "when user not found" do
      it "display flash warning " do
        get :edit, params: {
          id: -1
        }
        expect(flash[:danger]).to eq I18n.t("admin.users.show.show_user_failed")
      end

      it "redirect admin users page" do
        get :edit, params: {
          id: -1
        }
        expect(response).to redirect_to admin_users_path
      end
    end
  end

  describe "POST /update" do
    context "success when update valid attributes" do
      before do
        patch :update, xhr: true, params: {
          id: user_2.id,
          user: {name: "Change Name"}
        }
        user_2.reload
      end

      it "update db success" do
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

      it "update failed" do
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

      it "display danger flash" do
        expect(flash[:danger]).to eq I18n.t("admin.users.show.show_user_failed")
      end
    end
  end
end
