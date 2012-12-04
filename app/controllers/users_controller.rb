class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @install_cmd = "gem install git-feats"
    @conf_cmd = format_conf_command(@user)
    @alias_cmd = "echo 'alias git=git-feats' >> .bashrc"
    @one_liner = [@conf_cmd, @install_cmd, @alias_cmd].join(" && ") 
  end

  def destroy
  end

  private

  # Returns a one-liner git config command 
  # to be used with the git-feats gem
  #
  # user - A User that the command will be for
  def format_conf_command(user)
    "git config --global feats.key #{user.nickname}-#{user.gemkey}"
  end
end
