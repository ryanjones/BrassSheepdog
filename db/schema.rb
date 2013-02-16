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

ActiveRecord::Schema.define(:version => 20111114060650) do

  create_table "addresses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_string"
  end

  create_table "election_candidates", :force => true do |t|
    t.string   "row_key"
    t.string   "contest"
    t.string   "candidate_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "election_result_sets", :force => true do |t|
    t.integer  "votes_cast"
    t.integer  "reporting"
    t.integer  "out_of"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "election_results", :force => true do |t|
    t.integer  "election_candidate_id"
    t.integer  "election_result_set_id"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_statuses", :force => true do |t|
    t.boolean  "northeast_open"
    t.boolean  "northwest_open"
    t.boolean  "south_open"
    t.datetime "update_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "garbage_coordinates", :force => true do |t|
    t.float    "x"
    t.float    "y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "garbage_region_id"
  end

  create_table "garbage_pickups", :force => true do |t|
    t.string   "entity_id"
    t.datetime "pickup_date"
    t.string   "zone"
    t.integer  "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "garbage_pickups", ["entity_id"], :name => "index_garbage_pickups_on_entity_id", :unique => true
  add_index "garbage_pickups", ["zone", "day"], :name => "index_garbage_pickups_on_zone_and_day"

  create_table "garbage_regions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "garbage_zone_id"
  end

  create_table "garbage_zones", :force => true do |t|
    t.string   "zone"
    t.integer  "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roadway_alerts", :force => true do |t|
    t.string   "atom_title"
    t.datetime "atom_modified"
    t.string   "atom_id"
    t.string   "atom_email"
    t.string   "alert_type"
    t.boolean  "in_effect"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_subscriptions", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "delivery_time"
    t.boolean  "sms_enabled",              :default => true
    t.string   "zone"
    t.integer  "day"
    t.boolean  "day_before",               :default => true
    t.boolean  "manual_zone"
    t.string   "address"
    t.boolean  "update_about_northeast",   :default => true
    t.boolean  "update_about_northwest",   :default => true
    t.boolean  "update_about_southside",   :default => true
    t.boolean  "send_only_on_change",      :default => true
    t.boolean  "previous_northeast_state"
    t.boolean  "previous_northwest_state"
    t.boolean  "previous_southside_state"
    t.boolean  "current_northeast_state"
    t.boolean  "current_northwest_state"
    t.boolean  "current_southside_state"
    t.boolean  "email_enabled",            :default => true
    t.integer  "previous_votes_cast",      :default => 0
    t.integer  "pill_day",                 :default => 0
    t.datetime "pill_delivery_time"
    t.integer  "pill_length",              :default => 0
    t.datetime "updated_by_user"
    t.datetime "last_roadway_update_sent"
    t.boolean  "winter_parking_ban",       :default => false
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.string   "description"
    t.boolean  "enabled",      :default => true
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "phone_number"
    t.string   "verification_no"
    t.boolean  "admin",                                    :default => false
    t.boolean  "verified"
    t.date     "verification_try"
    t.string   "reset_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["phone_number"], :name => "index_users_on_phone_number", :unique => true

end
