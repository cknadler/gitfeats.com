class ApiController < ApplicationController
  before_filter :load_user
  
  def post_feats
    if @user
      update_history( params[:history] )
      complete_feats
    end
    render :nothing => true
  end
  
  private
    def load_user
      @user = User.find_by_nickname_and_gemkey(params[:username], params[:key])
    end
    
    def update_history( histories )
      histories.each do |h_name, h_count|
        command = Command.find_by_name(h_name)
        ch = CommandHistory.find_or_create_by_user_id_and_command_id(@user.id, command.id)
        ch.count = h_count if !ch.count || h_count > ch.count
        ch.save
      end
    end
    
    def complete_feats
      feats = Feat.joins(:command => "command_histories")
                  .where("command_histories.user_id = ? AND 
                          command_histories.count >= feats.threshold", @user.id)
      feats.each do |feat|
        CompletedFeat.find_or_create_by_user_id_and_feat_id(@user.id, feat.id)
      end
 
    end
end
