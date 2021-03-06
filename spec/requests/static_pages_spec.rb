require 'spec_helper'

describe "static pages" do
  subject { page }

  describe 'home page' do
    before do
      visit root_path
    end

    it { should have_link 'Get Started', :href => login_path }
    it { should have_link 'Site on GitHub',
         :href => 'https://github.com/cknadler/gitfeats.com' }
    it { should have_link 'Gem on GitHub', 
         :href => 'https://github.com/cknadler/git-feats' }
  end
end

