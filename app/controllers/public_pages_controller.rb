class PublicPagesController < ApplicationController

  def home
    if logged_in?
      render 'public_pages/stats'
    end
  end
end
