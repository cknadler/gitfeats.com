class CompletedFeat < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat
  # attr_accessible :title, :body
end
