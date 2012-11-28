require 'oauth2'
class SessionsController < ApplicationController

    def new
      client = OAuth2::Client.new('d2b082d97afcd2282f58', 'fbf42062a04633298574914300abd70b84dd8e68', 
        :site => 'https://github.com',
        :authorize_path => '/login/oauth/authorize', 
        :access_token_path => '/login/oauth/access_token')
      url = client.auth_code.authorize_url(:redirect_url => authorize_url)
      redirect_to url
    end

    def authorize
      redirect_to root
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Logged out"
    end
end
