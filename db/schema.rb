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

ActiveRecord::Schema.define(version: 2020_01_17_210415) do

  create_table "game_images", force: :cascade do |t|
    t.string "height"
    t.string "width"
    t.integer "image_id"
    t.string "url"
    t.string "image_type"
    t.integer "game_id"
  end

  create_table "game_platforms", force: :cascade do |t|
    t.integer "game_id"
    t.integer "platform_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "summary"
    t.integer "igdb_id"
    t.boolean "custom"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.string "slug"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

  create_table "users_game_platforms", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_platform_id"
  end

end
