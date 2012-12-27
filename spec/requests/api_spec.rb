require 'spec_helper'

describe "Api" do
  subject { JSON.parse(response.body) }

  describe "feats" do
    let(:user) { create :user }
    let(:command) { create :command }

    context "success" do
      # 200
      describe "with valid username, key and history" do
        before do
          post "/api/feats", 
            :username => user.nickname,
            :key => user.apikey,
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("OK") }
      end
    end

    context "failure" do

      # 401 errors
      describe "with invalid username" do
        before do
          post "/api/feats", 
            :username => "invalid_username",
            :key => user.apikey,
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("Invalid username") }
      end

      describe "with invalid key" do
        before do
          post "/api/feats", 
            :username => user.nickname,
            :key => "invalid_key",
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("Invalid API key") }
      end

      # 422 errors
      describe "with no username" do
        before do
          post "/api/feats", 
            :key => user.apikey,
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(1).error }
      end

      describe "with no key" do
        before do
          post "/api/feats", 
            :username => user.nickname,
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(1).error }
      end

      describe "with no username or key" do
        before do
          post "/api/feats",
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(2).errors }
      end

      describe "with no params" do
        before do
          post "/api/feats"
        end
        
        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(3).errors }
      end
    end
  end
end
