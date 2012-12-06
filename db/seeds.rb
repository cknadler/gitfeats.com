# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

=begin
if we have the same yaml and database model - we can use the following
require 'active_record/fixtures'
Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "operating_systems")
=end

require 'yaml'
feats_path = 'db/feats.yml'
yaml = YAML.load_file(feats_path)
yaml.each do |command, feats|
  c = Command.find_or_create_by_name(command)
  feats.each do |feat, value|
    tmp = Feat.find_or_create_by_name(value[:name])
    tmp.description = value[:desc]
    tmp.command_id = c.id
    tmp.threshold = value[:count]
    tmp.save
  end
end
