class FeatsController < ApplicationController
  # GET /feats
  def index
    @feats = Feat.order("name ASC")
  end

  # GET /feats/1
  def show
    @feat = Feat.find(params[:id])

    @percent = completed_percentage(@feat)
    newest = @feat.completed_feats.last
    @newest_user = newest.user if newest

    # Current user completed feat? logic
    @user_completed_feat = @feat.owned_by_user(current_user) if current_user

    if @user_completed_feat
      @completed_on = @user_completed_feat.created_at.strftime("%b %d, %Y")
    end
  end

  private

  # Finds the percentage of users that have compelted a feat
  #
  # Returns percentage as an int
  def completed_percentage(feat)
    # Special case where there are no users
    return 0 if User.all.count == 0

    completed_num = CompletedFeat.find_all_by_feat_id(feat.id).count
    ((completed_num.to_f / User.all.count.to_f) * 100)
  end
end
