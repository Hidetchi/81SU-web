# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110604081808) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kifus", :force => true do |t|
    t.integer  "blackid"
    t.integer  "whiteid"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "rate",                                     :default => 1000
    t.integer  "country_id"
    t.integer  "wins",                                     :default => 0
    t.integer  "losses",                                   :default => 0
    t.integer  "streak",                                   :default => 0
    t.integer  "streak_best",                              :default => 0
    t.boolean  "show_ranking"
    t.integer  "max_rate"
    t.integer  "wins34"
    t.integer  "losses34"
    t.string   "latest_ip_address"
    t.string   "avatar_image_url"
    t.text     "pr"
    t.string   "auth_token"
  end

  add_index "players", ["login"], :name => "index_players_on_login", :unique => true

  create_table "players_titles", :force => true do |t|
    t.integer  "player_id"
    t.integer  "title_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rate_change_histories", :force => true do |t|
    t.integer  "player_id"
    t.integer  "change"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "population"
    t.datetime "started_at"
    t.datetime "updated_at"
    t.datetime "maintenance_at"
    t.datetime "created_at"
  end

  create_table "titles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
