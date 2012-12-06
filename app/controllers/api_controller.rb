class ApiController < ApplicationController
  before_filter :load_user
  
  def post_feats
    update_history( params[:history] )
    complete_feats
    

    render :nothing => true
  end
  
  private
    def load_user
      @user = User.find_by_nickname(params[:username])
    end
    
    def update_history( histories )
        histories.each do |h_name, h_count|
        command = Command.find_by_name(h_name)
        ch = CommandHistory.find_or_create_by_user_id_and_command_id(@user.id, command.id)
        ch.count = h_count
        ch.save
      end
    end
    
    def complete_feats
      
    end
end
