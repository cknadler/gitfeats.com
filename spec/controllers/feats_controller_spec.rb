require 'spec_helper'

describe FeatsController do
  let(:feat) { create :feat }

  describe "GET show" do
    before do
      get :show, :id => feat.id
    end

    it { should respond_with(200) }
  end

  describe "GET index" do
    before do
      get :index
    end

    it { should respond_with(200) }
  end
end
