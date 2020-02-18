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

ActiveRecord::Schema.define(version: 2020_02_06_154335) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "after_parties", force: :cascade do |t|
    t.string "event_id", null: false
    t.string "party_place", null: false
    t.integer "party_postalcode"
    t.string "party_address"
    t.text "party_overview", null: false
    t.integer "party_fee", null: false
    t.string "party_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entry_tables", force: :cascade do |t|
    t.integer "event_user_id"
    t.integer "music_id", null: false
    t.integer "part_id", null: false
    t.integer "recruitment_status", null: false
    t.integer "requirement_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["music_id", "part_id"], name: "index_entry_tables_on_music_id_and_part_id", unique: true
  end

  create_table "event_thread_comments", force: :cascade do |t|
    t.integer "event_thread_id", null: false
    t.integer "user_id", null: false
    t.text "comment", null: false
    t.decimal "score", precision: 5, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_threads", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.integer "part_id", null: false
    t.integer "party_participate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "user_id"], name: "index_event_users_on_event_id_and_user_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "event_name", null: false
    t.string "friendly_url", null: false
    t.text "overview", null: false
    t.date "date", null: false
    t.datetime "meeting_time", null: false
    t.datetime "start_time", null: false
    t.datetime "finish_time", null: false
    t.datetime "entry_start_time", null: false
    t.datetime "entry_finish_time"
    t.string "place", null: false
    t.string "place_url"
    t.integer "performance_fee"
    t.integer "visit_fee"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_name"], name: "index_events_on_event_name", unique: true
    t.index ["friendly_url"], name: "index_events_on_friendly_url", unique: true
  end

  create_table "levels", force: :cascade do |t|
    t.integer "threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "music_comments", force: :cascade do |t|
    t.integer "music_id", null: false
    t.integer "user_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "score", precision: 5, scale: 3
  end

  create_table "musics", force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "title", null: false
    t.string "artist", null: false
    t.string "music_url"
    t.integer "establishment_status", default: 0, null: false
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "parts", force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "part_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "nickname"
    t.string "image_id"
    t.text "introduction"
    t.integer "exp", default: 0
    t.integer "level_id", default: 1
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
