class PagesController < ApplicationController
  before_action :get_user
  before_action :user_is_logged_in?, except: :home

  def home
  end

  def dashboard
  end

  private

  def get_user
    @current_user = User.find_by(uid: session[:oktastate])
  end

end