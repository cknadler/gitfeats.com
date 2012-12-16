require 'spec_helper'

describe "static pages" do

  describe 'home page' do
    it "has a Log in with GitHub link" do
      visit root_path
    end
  end
end
