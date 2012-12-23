# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# General Seeds

# Load git-feats tracked commands and feats
require 'yaml'

FEATS_PATH = 'db/feats.yml'

YAML.load_file(FEATS_PATH).each do |command, feats|
  command = Command.find_or_create_by_name(command)
  feats.each do |feat_id, value|
    feat = Feat.find_or_create_by_name(value[:name])
    feat.description = value[:desc]
    feat.filename = "#{feat_id}.png"
    feat.command_id = command.id
    feat.threshold = value[:count]
    feat.save
  end
end

# Development Seeds

# Seeds a development environment with users
if Rails.env.development? && User.count == 0
  require 'factory_girl_rails'
  require 'faker'
  include FactoryGirl::Syntax::Methods

  GRAVATARS = [
    '9dadbb73014fa13662157313d561379d',
    '67b26730dbb054da2aefd328708c5b0d',
    'a36d4f1831b3e2c95fa1e42fc45f82d5',
    'cbd4648e4cd1dd7e8737c8ca91fcda02',
    '57a90b685ef5eb6b17edf33fa91c4ea8',
    '8ddbf811da78bb0daeeb3cacd7cf743f',
    '0f9f17758e76da17ff4ade389e566321',
    'fde332d18b14c52bc41b50f4952f075a',
    '839ad4b6cf103f3ed8e05f07dbd7bccf',
    'f3c558eae6312364be3b963075c6ede5',
    '8edb1495667a6a78ccac104520d2f3af',
    '9a4455db54250482b24213bc4e734683'
  ]

  USERS = 100
  puts "Inserting #{USERS} test users with random command histories"

  USERS.times do
    # Create a user with a random gravatar
    user = create :user, :gravatar_id => GRAVATARS.sample
    user.uid = user.nickname # For developer2 omniauth
    user.save!

    # Give each user an arbitrary number of commands used
    num_commands = rand(0..Command.all.count)

    Command.all.sample(num_commands).each do |command|
      history = create :command_history, 
        :command_id => command.id,
        :user_id => user.id
      history.save!
    end

    # Update the users feats based on command history
    feats = Feat.joins(:command => "command_histories")
                .where("command_histories.user_id = ? AND 
                        command_histories.count >= feats.threshold", user.id)

    feats.each do |feat|
      # fix this
      CompletedFeat.find_or_create_by_user_id_and_feat_id(user.id, feat.id)
    end
  end
end
