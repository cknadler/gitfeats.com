require 'spec_helper'

describe "layouts" do
  subject { page }

  describe 'footer' do
    before do
      visit root_path
    end

    it { should have_link 'Git Help', :href => 'http://git-scm.com' }
    it { should have_link 'Fork the Site',
         :href => 'https://github.com/cknadler/gitfeats.com' }
    it { should have_link 'Fork the Gem',
         :href => 'https://github.com/cknadler/git-feats' }
  end
end
