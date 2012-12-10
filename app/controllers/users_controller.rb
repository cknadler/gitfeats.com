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
    @api_key = "#{@user.gemkey}"
    @install_cmd = "gem install git-feats"
    @key_cmd = format_key_conf_command(@api_key)
    @user_cmd = format_user_conf_command(@user.nickname)
    @alias_cmd = "echo 'alias git=git-feats' >> .bashrc"
    @one_liner = [@user_cmd, @key_cmd, @install_cmd, @alias_cmd].join(" && ") 
  end

  def search 
    @user = User.find_by_nickname(params[:query].downcase)
    
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

  def format_key_conf_command(key)
    "git config --global feats.key #{key}"
  end

  def format_user_conf_command(user)
    "git config --global github.user #{user}"
  end
end
