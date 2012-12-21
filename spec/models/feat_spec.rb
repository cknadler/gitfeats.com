# == Schema Information
#
# Table name: feats
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  command_id  :integer
#  threshold   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  filename    :string(255)
#

require 'spec_helper'

describe Feat do
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:threshold) }
  it { should allow_mass_assignment_of(:filename) }

  it { should have_many(:completed_feats) }

  it { should belong_to(:command) }
end
