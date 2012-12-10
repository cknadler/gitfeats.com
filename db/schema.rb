# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121208115734) do

  create_table "command_histories", :force => true do |t|
    t.integer  "count"
    t.integer  "command_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "command_histories", ["command_id"], :name => "index_command_histories_on_command_id"
  add_index "command_histories", ["user_id"], :name => "index_command_histories_on_user_id"

  create_table "commands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "completed_feats", :force => true do |t|
    t.integer  "user_id"
    t.integer  "feat_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "completed_feats", ["feat_id"], :name => "index_completed_feats_on_feat_id"
  add_index "completed_feats", ["user_id"], :name => "index_completed_feats_on_user_id"

  create_table "feats", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "command_id"
    t.integer  "threshold"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "filename"
  end

  add_index "feats", ["command_id"], :name => "index_feats_on_command_id"

  create_table "users", :force => true do |t|
    t.integer  "uid"
    t.string   "provider"
    t.string   "nickname"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "gemkey"
    t.boolean  "authenticated", :default => false
  end

end
