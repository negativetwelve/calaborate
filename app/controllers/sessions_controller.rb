class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:create, :destroy] 

  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.courses.count > 0
      redirect_to root_url
    else
      redirect_to settings_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end