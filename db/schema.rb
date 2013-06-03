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

ActiveRecord::Schema.define(:version => 20130603171249) do

  create_table "playlists", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "uid",        :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.hstore   "properties"
  end

  add_index "playlists", ["properties"], :name => "playlists_properties"
  add_index "playlists", ["uid"], :name => "index_playlists_on_uid", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.string   "password_salt",      :default => "", :null => false
    t.string   "name",               :default => "", :null => false
    t.string   "uid",                :default => "", :null => false
    t.string   "access_token",       :default => "", :null => false
    t.string   "refresh_token",      :default => "", :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.hstore   "properties"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["properties"], :name => "users_properties"
  add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true

  add_foreign_key "playlists", "users", :name => "playlists_user_id_fk", :dependent => :delete

end
