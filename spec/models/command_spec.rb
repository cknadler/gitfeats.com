# == Schema Information
#
# Table name: commands
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Command do
  it { should allow_mass_assignment_of(:name) }

  it { should have_many(:feats) }
  it { should have_many(:command_histories) }
end
