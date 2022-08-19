class Admin::UsersController < ApplicationController
  layout "layouts/application_admin"
  before_action :logged_in_user
  before_action :check_admin
  before_action :load_user, except: %i(index)

  def index
    @pagy, @users = pagy(User.all.lastest, items: Settings.user.per_page)
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      success_format t ".update_success"
    else
      danger_format t ".update_failed"
    end
  end

  def destroy
    total = User.all.count
    index = User.all.find_index(@user)
    if @user.destroy
      cur_page = handle_page total, index
      @pagy, @users = pagy(User.all.lastest, items: Settings.user.per_page,
                            page: cur_page)
      success_format t ".destroy_success"
    else
      danger_format t ".destroy_danger"
    end
  end

  private

  def handle_page total, index
    cur_page = (((total - index) - 1) / Settings.user.per_page).ceil + 1

    users = User.limit(Settings.user.per_page).offset(
      Settings.user.per_page * (cur_page - 1)
    )
    cur_page -= 1 if users.empty?
    cur_page
  end

  def load_user
    @user = User.find_by id: params[:id]
    flash[:success] = I18n.t "admin.users.show.show_user_success"
    return if @user

    flash[:danger] = I18n.t "admin.users.show.show_user_failed"
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit User::UPDATABLE_ATTRS
  end
end
