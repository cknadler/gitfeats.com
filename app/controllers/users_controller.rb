class UsersController < ApplicationController
  def show

    @user = User.find_by_nickname(params[:nickname])
    @feats = @user.completed_feats.reverse
    @allFeatCount = Feat.count
    @percent = ((@feats.count.to_f/@allFeatCount.to_f)*100).to_i
    @command_history = @user.command_histories

    # Setup data
    @api_key = "#{@user.nickname}-#{@user.gemkey}"
    @install_cmd = "gem install git-feats"
    @conf_cmd = format_conf_command(@api_key)
    @alias_cmd = "echo 'alias git=git-feats' >> .bashrc"
    @one_liner = [@conf_cmd, @install_cmd, @alias_cmd].join(" && ") 
  end

  private

  def format_conf_command(key)
    "git config --global feats.key \"#{key}\""
  end
end
