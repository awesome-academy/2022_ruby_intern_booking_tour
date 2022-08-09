class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
    else
      flash.now[:danger] = t ".login_failed"
      render :new
    end
  end

  def destroy
    return unless logged_in?

    log_out
    redirect_to root_url
  end

  private
  def log_in_user
    log_in @user
    flash[:success] = t ".login_success"
    redirect_back_or root_path if @user.user?

    redirect_back_or admin_users_path if @user.admin?
  end
end
