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

ActiveRecord::Schema.define(version: 20160817212010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "responses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "error"
    t.string   "essay"
    t.boolean  "correct"
    t.string   "corrected"
    t.string   "uncorrected"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "quota"
    t.string   "correct_answer"
    t.integer  "round_number"
    t.string   "controller"
    t.json     "actions"
    t.float    "total_time_to_edit"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "time_to_complete_in_seconds"
    t.string   "name"
    t.string   "treatment"
    t.integer  "round_number"
    t.float    "running_total_payment"
    t.float    "round_payment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "completed_in_time",           default: false
    t.datetime "end_time"
    t.boolean  "early_exit"
    t.float    "time_elapsed_in_seconds"
    t.integer  "option"
  end

  add_index "rounds", ["user_id"], name: "index_rounds_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group"
    t.string   "time_to_complete"
    t.string   "participant_id"
    t.float    "total_payment",      default: 0.0
    t.string   "job"
    t.json     "available_payments"
  end

end
