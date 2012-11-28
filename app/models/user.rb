class User < ActiveRecord::Base
  attr_accessible :admin, :first_name, :last_name, :username
  has_many :authorizations
  validates :username, :presence => true
end
