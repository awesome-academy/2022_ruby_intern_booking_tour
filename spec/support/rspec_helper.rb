module RspecHelper
  def log_in user
    request.session[:user_id] = user.id
  end
end
