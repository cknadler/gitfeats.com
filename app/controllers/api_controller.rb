class ApiController < ApplicationController
  def post_feats
    render :nothing => true
  end

  private

  # Takes a JSON object and returns formatted ruby Hash
  def parse_data(data)
  end
end
