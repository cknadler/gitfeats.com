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

class CompletedFeat < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat
  # attr_accessible :title, :body
end
