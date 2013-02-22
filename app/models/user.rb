# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  uid         :string(255)
#  provider    :string(255)
#  nickname    :string(255)
#  email       :string(255)
#  token       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  apikey      :string(255)
#  gravatar_id :string(255)
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessible :uid, :email, :nickname, :provider, :token, :gravatar_id

  has_many :completed_feats,   :dependent => :destroy
  has_many :command_histories, :dependent => :destroy

  before_save :create_apikey

  # Find a user by nickname ignoring case and 404 if name isn't found
  def self.find_by_nickname!(nickname)
    where(['lower(nickname) =?', nickname.downcase]).first!
  end

  # Override find_by_nickname to ignore case
  def self.find_by_nickname(nickname)
    where(['lower(nickname) =?', nickname.downcase]).first
  end

  def self.create_from_auth_hash(hash)
    create!(extract_info(hash))
  end

  def self.find_by_auth_hash(hash)
    conditions = extract_info(hash).slice(:provider, :uid)
    where(conditions).first
  end

  def to_param
    nickname
  end

  def github_url
    "https://github.com/#{nickname}"
  end

  def conf_apikey_cmd
    "git config --global feats.key #{apikey}"
  end

  def conf_user_cmd
    "git config --global github.user #{nickname}"
  end

  private

  def create_apikey
    self.apikey = Digest::SHA1.hexdigest(Time.now.to_s)
  end

  def self.extract_info(hash)
    {
      :uid         => hash.fetch('uid'),
      :provider    => hash.fetch('provider'),
      :token       => hash.fetch('credentials', {}).fetch('token'),
      :nickname    => hash.fetch('info',{}).fetch('nickname'),
      :email       => hash.fetch('info',{}).fetch('email', nil),
      :gravatar_id => hash.fetch('extra',{}).fetch('raw_info',{}).fetch('gravatar_id', nil)
    }
  end
end
