class Feat < ActiveRecord::Base
  belongs_to :command
  attr_accessible :description, :name, :threshold
end
