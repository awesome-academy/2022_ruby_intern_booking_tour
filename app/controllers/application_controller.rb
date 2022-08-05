class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  add_flash_types :success, :danger, :warning
  before_action :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".edit_login_danger"
    redirect_to login_path
  end

  def check_admin
    return true if current_user.role.zero?

    flash[:danger] = t ".check_admin.permission"
    redirect_to root_path
  end
end
