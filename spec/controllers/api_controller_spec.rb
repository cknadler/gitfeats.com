require 'spec_helper'

describe ApiController do

  describe "POST feats" do
    let(:user) { create :user }
    let(:command) { create :command }

    context "success" do
      describe "valid username, key and data" do
        before do
          post :feats,
            :username => user.nickname,
            :key => user.apikey,
            :history => { command.name => 1 }
        end
        
        it { should respond_with(200) }
        it { should respond_with_content_type(:json) }
      end
    end

    context "unauthorized" do
      context "invalid key" do
        before do
          post :feats,
            :username => user.nickname,
            :key => "invalid_key",
            :history => { command.name => 1 }
        end

        it { should respond_with(401) }
        it { should respond_with_content_type(:json) }
      end

      context "invalid username" do
        before do
          post :feats,
            :username => "invalid_username",
            :key => user.apikey,
            :history => { command.name => 1 }
        end

        it { should respond_with(401) }
        it { should respond_with_content_type(:json) }
      end
    end

    context "unprocessable" do
      context "no username" do
        before do
          post :feats,
            :key => user.apikey,
            :history => { command.name => 1 }
        end

        it { should respond_with(422) }
        it { should respond_with_content_type(:json) }
      end

      context "no apikey" do
        before do
          post :feats,
            :username => user.nickname,
            :history => { command.name => 1 }
        end

        it { should respond_with(422) }
        it { should respond_with_content_type(:json) }
      end
      
      context "no history" do
        before do
          post :feats,
            :username => user.nickname,
            :key => user.apikey
        end

        it { should respond_with(422) }
        it { should respond_with_content_type(:json) }
      end

    end
  end
end
