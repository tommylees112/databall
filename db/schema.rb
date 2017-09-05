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

ActiveRecord::Schema.define(version: 20170905131807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

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
    t.string   "name"
  end

  create_table "leagues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "match_model_outputs", force: :cascade do |t|
    t.float    "home_win_probability"
    t.float    "away_win_probability"
    t.float    "draw_probability"
    t.datetime "date_updated"
    t.integer  "match_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["match_id"], name: "index_match_model_outputs_on_match_id", using: :btree
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
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.float    "home_adj_goals"
    t.float    "away_adj_goals"
    t.float    "home_shot_xg"
    t.float    "away_shot_xg"
    t.float    "home_non_shot_xg"
    t.float    "away_non_shot_xg"
    t.string   "url"
    t.float    "final_home_win_probability"
    t.float    "final_away_win_probability"
    t.float    "final_draw_probability"
    t.string   "outcome"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id", using: :btree
    t.index ["home_team_id"], name: "index_matches_on_home_team_id", using: :btree
    t.index ["league_id"], name: "index_matches_on_league_id", using: :btree
  end

  create_table "odds", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "bookmaker_id"
    t.float    "odds"
    t.string   "outcome"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.float    "rating"
    t.boolean  "odds_bias_filter", default: false, null: false
    t.string   "frac_odd"
    t.index ["bookmaker_id"], name: "index_odds_on_bookmaker_id", using: :btree
    t.index ["match_id"], name: "index_odds_on_match_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.string   "stripe_id",     null: false
    t.string   "name",          null: false
    t.decimal  "display_price", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "team_model_outputs", force: :cascade do |t|
    t.float    "defensive_score"
    t.float    "offensive_score"
    t.float    "simulated_wins"
    t.float    "simulated_losses"
    t.float    "simulated_draws"
    t.float    "simulated_goal_difference"
    t.float    "simulated_season_total"
    t.float    "relegation_probability"
    t.float    "ucl_probability"
    t.string   "league_win_probability"
    t.datetime "last_updated"
    t.float    "promotion_probability"
    t.float    "playoff_probability"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "team_id"
    t.float    "soccer_power_index"
    t.index ["team_id"], name: "index_team_model_outputs_on_team_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "league_id"
    t.index ["league_id"], name: "index_teams_on_league_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.boolean  "admin",                  default: false, null: false
    t.jsonb    "stripe_customer"
    t.boolean  "access",                 default: true
    t.jsonb    "stripe_subscription"
    t.datetime "trial_end"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bets", "odds"
  add_foreign_key "bets", "users"
  add_foreign_key "match_model_outputs", "matches"
  add_foreign_key "matches", "leagues"
  add_foreign_key "matches", "teams", column: "away_team_id"
  add_foreign_key "matches", "teams", column: "home_team_id"
  add_foreign_key "odds", "bookmakers"
  add_foreign_key "odds", "matches"
  add_foreign_key "team_model_outputs", "teams"
  add_foreign_key "teams", "leagues"
end
