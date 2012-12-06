class CommandHistory < ActiveRecord::Base
  belongs_to :command
  belongs_to :user
  attr_accessible :count
end
