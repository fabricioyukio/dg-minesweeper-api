# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_10_083351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.string "status", default: "CREATED", null: false
    t.integer "columns", default: 4, null: false
    t.integer "lines", default: 4, null: false
    t.integer "mines_total", default: 3, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "grid", default: {}, null: false
    t.bigint "player_id", null: false
    t.index ["name"], name: "index_games_on_name", unique: true
    t.index ["player_id"], name: "index_games_on_player_id"
  end

  create_table "logs", force: :cascade do |t|
    t.string "event"
    t.string "description"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_logs_on_game_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["username"], name: "index_players_on_username", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id", "player_id"], name: "index_sessions_on_game_id_and_player_id", unique: true
    t.index ["game_id"], name: "index_sessions_on_game_id"
    t.index ["player_id"], name: "index_sessions_on_player_id"
  end

  add_foreign_key "games", "players"
  add_foreign_key "logs", "games"
  add_foreign_key "sessions", "games"
  add_foreign_key "sessions", "players"
end
