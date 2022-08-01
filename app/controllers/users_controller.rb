class UsersController < ApplicationController
  def show; end

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

  private
  def user_params
    params.require(:user).permit User::UPDATABLE_ATTRS
  end
end
