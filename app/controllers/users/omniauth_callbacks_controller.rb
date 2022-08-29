class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      session["user_id"] = @user.id
      redirect_to root_path
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
                                             .except(:extra)
      redirect_to signup_path
    end
  end
end
