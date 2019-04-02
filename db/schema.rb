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

ActiveRecord::Schema.define(version: 2019_04_02_202133) do

  create_table "reservations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.decimal "total_price", precision: 5, scale: 2
    t.integer "vehicle_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_category_id"], name: "index_reservations_on_vehicle_category_id"
  end

  create_table "vehicle_categories", force: :cascade do |t|
    t.string "name"
    t.decimal "daily_price", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_vehicle_categories_on_name", unique: true
  end

  create_table "vehicle_models", force: :cascade do |t|
    t.string "make"
    t.string "name"
    t.integer "vehicle_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["make", nil], name: "index_vehicle_models_on_make_and_model", unique: true
    t.index ["vehicle_category_id"], name: "index_vehicle_models_on_vehicle_category_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer "year"
    t.integer "vehicle_model_id"
    t.date "commissioned_on"
    t.date "decommissioned_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_model_id"], name: "index_vehicles_on_vehicle_model_id"
  end

end
