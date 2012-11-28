require 'oauth2'
require 'yaml'

class SessionsController < ApplicationController
    before_filter :load_info, :only => [:new]

    def new
      client = OAuth2::Client.new(@id, @secret, 
        :site => 'https://github.com',
        :authorize_path => '/login/oauth/authorize', 
        :access_token_path => '/login/oauth/access_token')
      url = client.auth_code.authorize_url(:redirect_url => authorize_url)
      redirect_to url
    end

    def authorize
      redirect_to root_path
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Logged out"
    end

    def load_info
      file = YAML.load_file("config/git_secret.yml")
      @secret = file["secret"] 
      @id = file["id"]
    end
end
