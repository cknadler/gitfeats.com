require 'spec_helper'

describe UsersController do
  let(:user) { create :user }

  describe "GET show" do
    context "with valid username" do
      before do
        get :show, :nickname => user.nickname
      end

      it { should respond_with(200) }
    end

    context "with an improperly capitalized username" do
      before do
        get :show, :nickname => user.nickname.upcase
      end

      it { should respond_with(200) }
    end

    context "with an invalid username" do
      it "should 404 on bad username" do
        assert_raises(ActiveRecord::RecordNotFound) do
          get :show, :nickname => "bad_nickname"
        end
      end
    end
  end

  describe "GET search" do
    before do
      request.env['HTTP_REFERER'] = root_url
    end

    context "with valid username" do
      before do
        get :search, :query => user.nickname
      end

      it { should respond_with(302) }
    end

    context "with improperly capitalized username" do
      before do
        get :search, :query => user.nickname.upcase
      end

      it { should respond_with(302) }
    end

    context "with an invalid username" do
      before do
        get :search, :query => "bad_nickname"
      end

      it { should respond_with(302) }
    end

    context "with no query" do
      before do
        get :search
      end

      it { should respond_with(302) }
    end
  end
end
