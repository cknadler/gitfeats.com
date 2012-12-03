class ApiController < ApplicationController
  respond_to :json
  def apipost
    render :text => "hi"
  end
end
