class PublicPagesController < ApplicationController

  def home
    if logged_in?
      render 'public_pages/stats'
    end
  end
  
  def stats
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
    
    @top_users = []
    tmp = get_users(10, true)
    tmp.each do |x|
      t = {}
      t[:id] = x.id
      t[:nickname] = x.nickname
      t[:feat_count] = x.completed_feats.count
      @top_users.push(t)
    end
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
