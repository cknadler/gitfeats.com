# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  uid        :integer
#  provider   :string(255)
#  nickname   :string(255)
#  email      :string(255)
#  token      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  apikey     :string(255)
#

require 'spec_helper'

describe User do
  let(:user) { create :user }
  
  it { should allow_mass_assignment_of(:uid) }
  it { should allow_mass_assignment_of(:provider) }
  it { should allow_mass_assignment_of(:nickname) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:token) }
end
