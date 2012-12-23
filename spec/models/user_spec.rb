# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  uid         :string(255)
#  provider    :string(255)
#  nickname    :string(255)
#  email       :string(255)
#  token       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  apikey      :string(255)
#  gravatar_id :string(255)
#

require 'spec_helper'

describe User do
  let(:user) { create :user }
  
  it { should allow_mass_assignment_of(:uid) }
  it { should allow_mass_assignment_of(:provider) }
  it { should allow_mass_assignment_of(:nickname) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:token) }
  it { should allow_mass_assignment_of(:gravatar_id) }

  it { should have_many(:completed_feats) }
  it { should have_many(:command_histories) }

  describe "apikey" do
    it "shouldn't be nil after user creation" do
      user.apikey.should_not == nil
    end

    it "should be the right length" do
      user.apikey.length.should == 40
    end
  end

  describe '.to_param' do
    subject { user.to_param }
    it { should eq user.nickname }
  end
end
