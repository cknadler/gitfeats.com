# == Schema Information
#
# Table name: commands
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Command < ActiveRecord::Base
  attr_accessible :name
  has_many :feats
  has_many :command_histories

  def global_use_count
    count = 0
    CommandHistory.where(:command_id => self.id).each do |c|
      count += c.count
    end
    return count
  end
end
