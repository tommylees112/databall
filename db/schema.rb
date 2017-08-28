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

ActiveRecord::Schema.define(version: 20170828142135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "odd_id"
    t.float    "stake"
    t.boolean  "won"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["odd_id"], name: "index_bets_on_odd_id", using: :btree
    t.index ["user_id"], name: "index_bets_on_user_id", using: :btree
  end

  create_table "bookmakers", force: :cascade do |t|
    t.string   "logo"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.integer  "goals_home_team"
    t.integer  "goals_away_team"
    t.datetime "match_date"
    t.integer  "gameweek"
    t.integer  "league_id"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["away_team_id"], name: "index_matches_on_away_team_id", using: :btree
    t.index ["home_team_id"], name: "index_matches_on_home_team_id", using: :btree
    t.index ["league_id"], name: "index_matches_on_league_id", using: :btree
  end

  create_table "odds", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "bookmaker_id"
    t.float    "odd"
    t.string   "outcome"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["bookmaker_id"], name: "index_odds_on_bookmaker_id", using: :btree
    t.index ["match_id"], name: "index_odds_on_match_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bets", "odds"
  add_foreign_key "bets", "users"
  add_foreign_key "matches", "leagues"
  add_foreign_key "matches", "teams", column: "away_team_id"
  add_foreign_key "matches", "teams", column: "home_team_id"
  add_foreign_key "odds", "bookmakers"
  add_foreign_key "odds", "matches"
end
