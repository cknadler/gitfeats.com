class StatsController < ApplicationController

  def index
    # random feat
    @random_feat = Feat.all.sample(1).first
    
    #for most recent completed feat to display
    tmp = CompletedFeat.order("created_at DESC").limit(1)
    if tmp.first
      @latest_feat = Feat.find(tmp.first.feat_id)
      @latest_feat_user = User.find(tmp.first.user_id)
    end
    
    # completed feats progress bar
    @completed_feats_count = CompletedFeat.count
    @total_feats_count = User.count * Feat.count
    @percent = ((@completed_feats_count.to_f/@total_feats_count.to_f)*100).to_i
  
    # top commands
    @top_commands = []
    @top_command_count = 0
    tmp = get_commands(10, true)
    tmp.each do |x|
      t = {}
      t[:id] = x.id
      t[:name] = x.name
      t[:count] = x.global_use_count
      @top_command_count = t[:count] if t[:count] > @top_command_count
      @top_commands.push(t)
    end
    
    # top users
    @top_users = []
    tmp = get_users(7, true)
    tmp.each do |x|
      t = {}
      t[:id] = x.id
      t[:nickname] = x.nickname
      t[:feat_count] = x.completed_feats.count
      @top_users.push(t)
    end
    @top_users.reverse!
  end
  
  #count - how many rows wanted
  #top - boolean - if you want to lower or higher end of the data
  def get_commands(count, top=true)
    CommandHistory.commands_by_run_number(count, top)
  end
  
  def get_users(count, top=true)
    CompletedFeat.users_by_feats_completed(count, top)
  end
end
