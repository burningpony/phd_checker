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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150320145536) do

  create_table "responses", :force => true do |t|
    t.integer  "user_id"
    t.string   "error"
    t.string   "essay"
    t.boolean  "correct"
    t.string   "corrected"
    t.string   "uncorrected"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "quota"
    t.string   "correct_answer"
    t.integer  "round_number"
    t.string   "controller"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "time_to_complete_in_seconds"
    t.string   "name"
    t.string   "treatment"
    t.integer  "round_number"
    t.float    "running_total_payment"
    t.float    "round_payment"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.boolean  "completed_in_time",           :default => false
  end

  add_index "rounds", ["user_id"], :name => "index_rounds_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "group"
    t.string   "time_to_complete"
    t.string   "participant_id"
  end

end
