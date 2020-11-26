class SessionsController < ApplicationController
  def new
  end

  def create
  end

  def destroy
    session[:usersession] = nil
    @current_user = session[:usersession]
    @session = session[:usersession]
    redirect_to root_path
  end
end