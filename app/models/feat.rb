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

class Feat < ActiveRecord::Base
  belongs_to :command
  has_many :completed_feats

  attr_accessible :description, :name, :threshold, :filename

  # TODO: Refactor
  # Should return bool
  def owned_by_user(user)
    CompletedFeat.find_by_user_id_and_feat_id(user.id, self.id)
  end
end
