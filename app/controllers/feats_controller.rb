class FeatsController < ApplicationController
  # GET /feats
  def index
    @feats = Feat.all
  end

  # GET /feats/1
  def show
    @feat = Feat.find(params[:id])
    @last_user = @feat.completed_feats.last
    @last_user = @last_user.user if @last_user
    @num_completed = CompletedFeat.find_all_by_feat_id(params[:id]).count
    @percent = ((@num_completed.to_f/User.all.count.to_f)*100).to_i
  end

  def index
    @feats = Feat.order("name ASC")
  end 
end
