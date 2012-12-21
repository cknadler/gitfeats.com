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
  attr_accessible :count
  belongs_to :command
  belongs_to :user

  def self.commands_by_run_number(count, top)
    commands = Command.all.sort_by { |x| x.global_use_count }
    if top
      commands.last(count)
    else
      commands.first(count)
    end
  end
end
