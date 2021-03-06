class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :get_user
    
    def user_is_logged_in?
        if !session[:oktastate]
            Rails.logger.info "Sorry, user not yet logged in."
            redirect_to user_oktaoauth_omniauth_authorize_path
        end
    end

    def after_sign_in_path_for(resource)
        request.env['omniauth.origin'] || root_path
    end

    def get_user
        @current_user = User.find_by(uid: session[:oktastate]) if session[:oktastate]
    end
    
end