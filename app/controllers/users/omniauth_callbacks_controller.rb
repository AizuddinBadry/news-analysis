class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def oktaoauth
        @user = User.omniauth_authentication(request.env["omniauth.auth"])
        session[:usersession] = request.env["omniauth.auth"]["uid"] #set seesion if environment variable is omniauth.auth
        redirect_to root_path
    end
end