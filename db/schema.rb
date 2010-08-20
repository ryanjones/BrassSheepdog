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

ActiveRecord::Schema.define(:version => 20100820020346) do

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

  create_table "service_subscriptions", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "delivery_time"
    t.boolean  "enabled",       :default => true
    t.string   "zone"
    t.integer  "day"
    t.boolean  "day_before",    :default => true
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.string   "description"
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

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
