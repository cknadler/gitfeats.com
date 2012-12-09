# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  uid           :integer
#  provider      :string(255)
#  nickname      :string(255)
#  email         :string(255)
#  token         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  gemkey        :string(255)
#  authenticated :boolean          default(FALSE)
#

require 'digest'

class User < ActiveRecord::Base
  include Gravtastic
  has_gravatar
  
  has_many :completed_feats
  has_many :command_histories

  attr_accessible :email, :nickname, :provider, :token, :uid, :gemkey
  before_save :create_gemkey
  
  def self.create_from_auth_hash(hash)
    create!(extract_info(hash))
  end

  def self.find_by_auth_hash(hash)
    conditions = extract_info(hash).slice(:provider, :uid)
    where(conditions).first
  end

  private
  
  def create_gemkey
    self.gemkey = Digest::SHA1.hexdigest(Time.now.to_s)   
  end
  
  def self.extract_info(hash)
    provider    = hash.fetch('provider')
    uid         = hash.fetch('uid')
    nickname    = hash.fetch('info',{}).fetch('nickname')
    email       = hash.fetch('info',{}).fetch('email', nil)
    token       = hash.fetch('credentials', {}).fetch('token')
    
    {
      :provider => provider,
      :token => token,
      :uid => uid,
      :nickname => nickname,
      :email => email,
    }
  end
end
