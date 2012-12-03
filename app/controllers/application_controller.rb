class ApplicationController < ActionController::Base  
  before_filter :initialize_user
  protect_from_forgery
  helper_method :logged_in?
  
  def initialize_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    @current_user
  end
end
