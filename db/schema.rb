# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_04_221041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_details", force: :cascade do |t|
    t.string "statusGame"
    t.string "vTeamFullName"
    t.string "vTeamLogo"
    t.integer "vTeamId"
    t.integer "vPoints"
    t.integer "vQ1Score"
    t.integer "vQ2Score"
    t.integer "vQ3Score"
    t.integer "vQ4Score"
    t.string "hTeamFullName"
    t.string "hTeamLogo"
    t.integer "hTeamId"
    t.integer "hPoints"
    t.integer "hQ1Score"
    t.integer "hQ2Score"
    t.integer "hQ3Score"
    t.integer "hQ4Score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "gameId"
  end

  create_table "games", force: :cascade do |t|
    t.integer "gameId"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "statusShortGame"
    t.string "statusGame"
    t.integer "vTeamId"
    t.string "vTeamShortName"
    t.integer "hTeamId"
    t.string "hTeamShortName"
    t.string "startTime"
  end

  create_table "historical_prices", force: :cascade do |t|
    t.integer "playerId"
    t.date "date"
    t.float "buy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "player_averages", force: :cascade do |t|
    t.integer "teamId"
    t.integer "playerId"
    t.float "points"
    t.string "pos"
    t.float "min"
    t.float "fgm"
    t.float "fga"
    t.float "fgp"
    t.float "ftm"
    t.float "fta"
    t.float "ftp"
    t.float "tpm"
    t.float "tpa"
    t.float "tpp"
    t.float "offReb"
    t.float "defReb"
    t.float "totReb"
    t.float "assists"
    t.float "pFouls"
    t.float "steals"
    t.float "turnovers"
    t.float "blocks"
    t.integer "plusMinus"
    t.float "per"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.string "pos"
    t.integer "playerId"
    t.integer "teamId"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "qtyBought"
    t.integer "qtySold"
    t.float "sell"
    t.float "buy"
  end

  create_table "standings", force: :cascade do |t|
    t.integer "teamId"
    t.integer "win"
    t.integer "loss"
    t.string "conference"
    t.integer "rank"
    t.float "winP"
    t.float "lossP"
    t.integer "winStreak"
    t.integer "gamesPlayed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "shortName"
    t.string "teamName"
    t.string "teamLogo"
  end

  create_table "statistics", force: :cascade do |t|
    t.integer "gameId"
    t.integer "teamId"
    t.integer "playerId"
    t.integer "points"
    t.string "pos"
    t.integer "fgm"
    t.integer "fga"
    t.float "fgp"
    t.integer "ftm"
    t.integer "fta"
    t.float "ftp"
    t.integer "tpm"
    t.integer "tpa"
    t.float "tpp"
    t.integer "offReb"
    t.integer "defReb"
    t.integer "totReb"
    t.integer "assists"
    t.integer "pFouls"
    t.integer "steals"
    t.integer "turnovers"
    t.integer "blocks"
    t.integer "plusMinus"
    t.float "per"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "min"
  end

  create_table "teams", force: :cascade do |t|
    t.string "city"
    t.string "fullName"
    t.string "logo"
    t.string "nickname"
    t.string "shortName"
    t.string "confName"
    t.string "divName"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "teamId"
    t.integer "nbaFranchise"
  end

  create_table "user_players", force: :cascade do |t|
    t.integer "user_id"
    t.integer "playerId"
    t.integer "qtyOwned"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "boughtPrice"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.date "dob"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "account_balance"
  end

end
