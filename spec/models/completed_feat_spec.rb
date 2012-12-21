# == Schema Information
#
# Table name: completed_feats
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  feat_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe CompletedFeat do

  it { should belong_to(:user) }
  it { should belong_to(:feat) }
end
