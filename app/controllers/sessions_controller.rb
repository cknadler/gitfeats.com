class SessionsController < ApplicationController    
    def new
      redirect_to "/auth/github"
    end

    def create
      auth_hash = request.env['omniauth.auth']
      user      = User.find_by_auth_hash(auth_hash) ||
                  User.create_from_auth_hash(auth_hash)
      session[:user_id] = user.id
      redirect_to user
    end
    
    def failure
      redirect_to root_path
    end

    def destroy
      session.delete(:user_id)
      redirect_to root_path
    end
end
