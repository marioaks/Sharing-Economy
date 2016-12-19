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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161219010258) do

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id"

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.integer  "world110_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "countries_services", id: false, force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "service_id", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.text     "website"
    t.text     "description"
    t.integer  "founded"
    t.string   "topic"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "city_id"
  end

  add_index "services", ["city_id"], name: "index_services_on_city_id"

end
