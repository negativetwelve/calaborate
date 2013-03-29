class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :require_login

  private
  def current_user
    session[:user_id] = nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #@current_user = User.first
  end
  helper_method :current_user
  
  def require_login
    unless current_user
      redirect_to login_url
    end
  end

end
