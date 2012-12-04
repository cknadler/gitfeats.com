class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @conf_command = format_conf_command(@user)
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
