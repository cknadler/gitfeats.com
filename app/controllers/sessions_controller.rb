require 'json'
require 'open-uri'
class SessionsController < ApplicationController    
    def new

    end

#where the callback comes in
    def create
      auth_hash = request.env['omniauth.auth']
#      @user = get_user_info(auth_hash["extra"]["url"].split('/').last)
      @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      if @authorization
        render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
      else
        render :text => auth_hash["extra"]["info"].inspect
=begin        
        user = User.new :name => auth_hash["user_info"]["name"], :email => auth_hash["user_info"]["email"]
        user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
        user.save
        render :text => "Hi #{user.name}! You've signed up."
=end
      end
    end
    
    def failure

    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Logged out"
    end
    def get_user_info (name)
      url = "http://github.com/api/v1/json" + "/#{name}"
        JSON.parse(open(url).read)["user"]
    end
end
