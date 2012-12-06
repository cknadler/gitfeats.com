class ApiController < ApplicationController

  def post_feats
    user = User.find_by_nickname(params[:username])
    params[:history].each do |h_name, h_count|
      command = Command.find_by_name(h_name)
      ch = CommandHistory.find_or_create_by_user_id_and_command_id(user.id, command.id)
      ch.count = h_count
      ch.save
    end
    render :nothing => true
  end
end
