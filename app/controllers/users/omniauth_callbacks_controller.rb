class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def oktaoauth
        @current_user = User.from_omniauth(request.env["omniauth.auth"])
        session[:oktastate] = request.env["omniauth.auth"]["uid"]
        redirect_to pages_dashboard
     end
end