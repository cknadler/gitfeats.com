class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :initialize_user
  helper_method :logged_in?
  
  def initialize_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    @current_user
  end
end
