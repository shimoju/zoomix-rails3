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

ActiveRecord::Schema.define(:version => 20121203105436) do

  create_table "posts", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "text"
    t.datetime "posted_at"
    t.string   "source"
    t.string   "postid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "posts", ["postid", "source"], :name => "index_posts_on_postid_and_source", :unique => true

  create_table "timeline", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "timeline", ["post_id", "user_id"], :name => "index_timeline_on_post_id_and_user_id", :unique => true
  add_index "timeline", ["post_id"], :name => "index_timeline_on_post_id"
  add_index "timeline", ["user_id"], :name => "index_timeline_on_user_id"

  create_table "urls", :force => true do |t|
    t.string   "url"
    t.string   "original_url"
    t.integer  "post_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "urls", ["post_id"], :name => "index_urls_on_post_id"

  create_table "users", :force => true do |t|
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.binary   "access_token"
    t.binary   "access_token_secret"
    t.binary   "salt"
  end

  add_index "users", ["uid", "provider"], :name => "index_users_on_uid_and_provider", :unique => true

end
