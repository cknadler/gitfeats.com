class RootController < ApplicationController

  def index
    if logged_in?
      redirect_to stats_path
    else
      render 'public_pages/home' 
    end
  end
end
