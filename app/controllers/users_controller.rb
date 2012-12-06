class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

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
