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

ActiveRecord::Schema.define(version: 20170403122432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "agency_id"
    t.string "agency_name"
    t.string "agency_url"
    t.string "agency_timezone"
    t.string "agency_lang"
    t.string "agency_phone"
    t.string "agency_fare_url"
    t.string "agency_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendar_dates", force: :cascade do |t|
    t.string "service_id"
    t.datetime "date"
    t.integer "exception_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendars", force: :cascade do |t|
    t.string "service_id"
    t.integer "monday"
    t.integer "tuesday"
    t.integer "wednesday"
    t.integer "thursday"
    t.integer "friday"
    t.integer "saturday"
    t.integer "sunday"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string "route_id"
    t.string "agency_id"
    t.string "route_short_name"
    t.string "route_long_name"
    t.string "route_desc"
    t.string "route_type"
    t.string "route_url"
    t.string "route_color"
    t.string "route_text_color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shapes", force: :cascade do |t|
    t.string "shape_id"
    t.decimal "shape_pt_lat", precision: 10, scale: 6
    t.decimal "shape_pt_lon", precision: 10, scale: 6
    t.integer "shape_pt_sequence"
    t.decimal "shape_dist_traveled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stop_times", force: :cascade do |t|
    t.string "trip_id"
    t.integer "arrival_hour"
    t.integer "arrival_minute"
    t.integer "arrival_second"
    t.integer "departure_hour"
    t.integer "departure_minute"
    t.integer "departure_second"
    t.string "stop_id"
    t.integer "stop_sequence"
    t.string "stop_headsign"
    t.integer "pickup_type", default: 0
    t.integer "drop_off_type", default: 0
    t.decimal "shape_dist_traveled"
    t.decimal "timepoint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stop_id"], name: "index_stop_times_on_stop_id"
    t.index ["trip_id"], name: "index_stop_times_on_trip_id"
  end

  create_table "stops", force: :cascade do |t|
    t.string "stop_id"
    t.string "stop_code"
    t.string "stop_name"
    t.text "stop_desc"
    t.decimal "stop_lat", precision: 10, scale: 6
    t.decimal "stop_lon", precision: 10, scale: 6
    t.string "zone_id"
    t.string "stop_url"
    t.integer "location_type", default: 0
    t.string "parent_station"
    t.string "timezone"
    t.integer "wheelchair_boarding"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.string "trip_id"
    t.string "route_id"
    t.string "service_id"
    t.string "trip_headsign"
    t.string "trip_short_name"
    t.integer "direction_id"
    t.string "block_id"
    t.string "shape_id"
    t.integer "wheelchair_accesible", default: 0
    t.integer "bikes_allowed", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
