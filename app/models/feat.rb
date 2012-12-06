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
  attr_accessible :description, :name, :threshold
end
