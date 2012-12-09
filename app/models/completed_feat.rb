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

def self.users_by_feats_completed(count, top)
 users = User.all.sort_by { |x| x.num_feats }
 if top
	users.last(count)
 else
	users.first(count)
 end
end

def self.feats_by_completion_number(count, top)
 feats = Feat.all.sort_by { |x| x.completed_feats.count }
 if top
	feats.last(count)
 else
	feats.first(count)
 end
end

end
