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

ActiveRecord::Schema.define(version: 20150430152936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "responses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "error",          limit: 255
    t.string   "essay",          limit: 255
    t.boolean  "correct"
    t.string   "corrected",      limit: 255
    t.string   "uncorrected",    limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "quota"
    t.string   "correct_answer", limit: 255
    t.integer  "round_number"
    t.string   "controller",     limit: 255
  end

  create_table "rounds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "time_to_complete_in_seconds"
    t.string   "name",                        limit: 255
    t.string   "treatment",                   limit: 255
    t.integer  "round_number"
    t.float    "running_total_payment"
    t.float    "round_payment"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.boolean  "completed_in_time",                       default: false
    t.datetime "end_time"
    t.boolean  "early_exit"
    t.float    "time_elapsed_in_seconds"
  end

  add_index "rounds", ["user_id"], name: "index_rounds_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "group",            limit: 255
    t.string   "time_to_complete", limit: 255
    t.string   "participant_id",   limit: 255
    t.float    "total_payment",                default: 0.0
  end

end
