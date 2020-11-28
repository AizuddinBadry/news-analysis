class PagesController < ApplicationController
  before_action :user_is_logged_in?, except: :home

  def home
  end

  def dashboard
  end

end