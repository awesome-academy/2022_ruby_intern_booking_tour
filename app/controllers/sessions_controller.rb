class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_back_or root_path
    else
      flash.now[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    return unless logged_in?

    log_out
    redirect_to root_url
  end
end
