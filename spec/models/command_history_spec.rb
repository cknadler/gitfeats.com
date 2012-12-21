# == Schema Information
#
# Table name: command_histories
#
#  id         :integer          not null, primary key
#  count      :integer
#  command_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe CommandHistory do
  it { should allow_mass_assignment_of(:count) }

  it { should belong_to(:command) }
  it { should belong_to(:user) }
end
