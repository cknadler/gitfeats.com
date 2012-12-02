class SessionsController < ApplicationController    
    def new
      redirect_to "/auth/github"
    end

    def create
      auth_hash = request.env['omniauth.auth']
      user      = User.find_by_auth_hash(auth_hash) ||
                    User.create_from_auth_hash(auth_hash)

      session[:user_id] = user.id
      
      redirect_to root_url, :notice => "Welcome #{user.nickname}"
    end
    
    def failure

    end

    def destroy
      username = User.find(:user_id).nickname
      session.delete(:user_id)
      redirect_to root_path, :notice => username + " has logged out"
    end
end
