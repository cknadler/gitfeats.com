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
#

class Feat < ActiveRecord::Base
  belongs_to :command
  has_many :completed_feats

  attr_accessible :description, :name, :threshold
  
  def owned_by_user (user, feat)
    CompletedFeat.find_by_user_id_and_feat_id(user.id, feat.id)
  end
end
