module UsersHelper

  def install_cmd
    "gem install git-feats"
  end

  def bash_alias
    "echo 'alias git=git-feats' >> ~/.bashrc"
  end

  # A user specific, one line, setup command
  def one_liner(user)
    [user.conf_user_cmd,
     user.conf_apikey_cmd,
     install_cmd,
     bash_alias].join(" && ")
  end
end
