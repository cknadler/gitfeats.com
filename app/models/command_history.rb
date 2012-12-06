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

class CommandHistory < ActiveRecord::Base
  belongs_to :command
  belongs_to :user
  attr_accessible :count
end
