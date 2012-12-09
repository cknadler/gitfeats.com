class UsersController < ApplicationController
  def show
    @user = User.find_by_nickname(params[:nickname])
    @feats = @user.completed_feats.reverse
    @all_feat_count = Feat.count
    @percent = ((@feats.count.to_f/@all_feat_count.to_f)*100).to_i
    @command_history = @user.command_histories

    @total = roundup(@feats.count, 3)
    @github_url = "http://www.github.com/#{@user.nickname}" 

    # Setup data
    @api_key = "#{@user.nickname}-#{@user.gemkey}"
    @install_cmd = "gem install git-feats"
    @conf_cmd = format_conf_command(@api_key)
    @alias_cmd = "echo 'alias git=git-feats' >> .bashrc"
    @one_liner = [@conf_cmd, @install_cmd, @alias_cmd].join(" && ") 
  end

  def search 
    @user = User.find_by_nickname(params[:query])

    if params[:query].nil?
      redirect_to :root

    # if empty query, redirect them back. <~ there has to be a better way
    elsif params[:query].empty?
      redirect_to(:back)

    # else if the search for user fails, go back and tell them
    elsif @user.nil?
      redirect_to(:back, :notice => "Could not find user #{params[:query]}")

    # else take them to the users page
    else
      redirect_to @user
    end
  end 

  private

  def roundup (num, ceiling)
    return num if num % ceiling  == 0
    return num + ceiling - (num % ceiling)
  end

  def format_conf_command(key)
    "git config --global feats.key \"#{key}\""
  end
end
