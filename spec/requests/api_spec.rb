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
      describe "with non-existant username" do
        before do
          post "/api/feats", 
            :username => "invalid_username",
            :key => user.apikey,
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("Invalid username") }
      end

      describe "with non-existant key" do
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

        it "should have the right error content" do
          subject["error"]["username"].should match("missing")
        end
      end

      describe "with no key" do
        before do
          post "/api/feats", 
            :username => user.nickname,
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(1).error }

        it "should have the right error content" do
          subject["error"]["key"].should match("missing")
        end
      end

      describe "with no username or key" do
        before do
          post "/api/feats",
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(2).errors }

        it "should have the right error content" do
          subject["error"]["username"].should match("missing")
          subject["error"]["key"].should match("missing")
        end
      end

      describe "with no params" do
        before do
          post "/api/feats"
        end
        
        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(3).errors }

        it "should have the right error content" do
          subject["error"]["username"].should match("missing")
          subject["error"]["key"].should match("missing")
          subject["error"]["history"].should match("missing")
        end
      end

      describe "with wrong type username" do
        before do
          post "/api/feats",
            :username => { :some => "hash" },
            :key => user.apikey,
            :history => { command.name => 1 }
        end

        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(1).error }

        it "should have the right error content" do
          subject["error"]["username"].should match("wrong_type")
        end
      end

      describe "with wrong type history" do
        before do
          post "/api/feats",
            :username => user.nickname,
            :key => user.apikey,
            :history => "some_string"
        end

        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(1).error }

        it "should have the right error content" do
          subject["error"]["history"].should match("wrong_type")
        end
      end

      describe "with wrong type key and history" do
        before do
          post "/api/feats",
            :username => user.nickname,
            :key => { :some => "hash" },
            :history => "some_string"
        end

        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(2).errors }

        it "should have the right error content" do
          subject["error"]["key"].should match("wrong_type")
          subject["error"]["history"].should match("wrong_type")
        end
      end

      describe "with invalid history keys" do
        before do
          history =
            {
              "invalid_cmd1" => 1,
              command.name => 1,
              "invalid_cmd2" => 1
            }
          
          post "/api/feats",
            :username => user.nickname,
            :key => user.apikey,
            :history => history
        end

        its(["message"]) { should match("Unprocessable") }
        its(["error"]) { should have(1).error }

        it "should have the right error content" do
          subject["error"]["history"]["invalid_cmd1"].should match("invalid")
          subject["error"]["history"]["invalid_cmd2"].should match("invalid")
        end
      end
    end
  end
end
