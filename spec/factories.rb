require 'securerandom'

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    uid { SecureRandom.hex }
    provider 'github'
    nickname { Faker::Name.name.parameterize }
    email
    token { SecureRandom.hex }
  end

  factory :feat do
    name { Faker::Lorem.word }
    description { Faker::Lorem.words }
    threshold { rand(1..99) }
    # default to a bricks and mortar feat image
    filename { "bricks_and_mortar.png" }
    command
  end

  factory :command do
    name { Faker::Lorem.word }
  end

  factory :command_history do
    count { Random.rand(1..1000) }
    command
    user
  end

  factory :completed_feat do
    user
    feat
  end
end
