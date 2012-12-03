class FeatsController < ApplicationController
  # GET /feats
  def index
    @feats = Feat.all
  end

  # GET /feats/1
  def show
    @feat = Feat.find(params[:id])
  end
end
