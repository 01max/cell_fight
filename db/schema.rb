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

ActiveRecord::Schema.define(version: 2019_07_10_153353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "fighters", force: :cascade do |t|
    t.string "name", null: false
    t.integer "attack_base_points"
    t.integer "defense_base_points"
    t.integer "health_base_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color_code"
    t.integer "xp", default: 1
  end

  create_table "fights", force: :cascade do |t|
    t.bigint "fighter_a_id"
    t.bigint "fighter_b_id"
    t.bigint "winner_id"
    t.json "hits", default: {}
    t.integer "xp_gain", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fighter_a_id"], name: "index_fights_on_fighter_a_id"
    t.index ["fighter_b_id"], name: "index_fights_on_fighter_b_id"
    t.index ["winner_id"], name: "index_fights_on_winner_id"
  end

end
