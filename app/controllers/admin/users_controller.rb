class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin
  before_action :load_user, except: %i(index)

  def index
    @pagy, @users = pagy(User.all, items: Settings.user.per_page)
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to admin_users_path
    else
      flash.now[:danger] = t ".update_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_danger"
    end
    redirect_to admin_users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    flash[:success] = t ".show_user_success"
    return if @user

    flash[:danger] = t ".show_user_failed"
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit User::UPDATABLE_ATTRS
  end
end
