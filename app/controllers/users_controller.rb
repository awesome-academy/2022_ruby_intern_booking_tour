class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(create new)
  before_action :check_admin, only: %i(index update destroy edit)
  before_action :load_user, except: %i(create new index)

  def index
    @pagy, @users = pagy(User.all, items: Settings.user.per_page)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".user_registering_successful"
      redirect_to root_url
    else
      flash.now[:danger] = t ".user_not_saved"
      render :new
    end
  end

  def show
    flash[:success] = t ".show_user_success"
    return if @user

    flash[:danger] = t ".show_user_failed"
    redirect_to users_path
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to users_path
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
    redirect_to users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    flash[:success] = t ".load_user.load_success"
    return if @user

    flash[:danger] = t ".load_user.load_failed"
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit User::UPDATABLE_ATTRS
  end
end
