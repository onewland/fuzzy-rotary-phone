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

ActiveRecord::Schema.define(version: 20160805211423) do

  create_table "matches", force: :cascade do |t|
    t.string   "x_player",                        null: false
    t.string   "o_player",                        null: false
    t.string   "channel",                         null: false
    t.datetime "accepted_at"
    t.string   "board"
    t.string   "current_turn",      default: "x"
    t.integer  "turns_taken_count", default: 0,   null: false
    t.text     "status"
    t.string   "winner_char"
    t.text     "winner_username"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "matches", ["channel", "status"], name: "index_matches_on_channel_and_status"

end
