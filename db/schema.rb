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

ActiveRecord::Schema.define(version: 20161129034716) do

  create_table "colleges", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address1",   limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "startdate"
    t.datetime "enddate"
    t.string   "url",          limit: 255
    t.integer  "event_type",   limit: 4
    t.integer  "college_id",   limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "description",  limit: 65535
    t.string   "address_temp", limit: 255
    t.boolean  "is_published"
    t.string   "email",        limit: 255
  end

  add_index "events", ["college_id"], name: "index_events_on_college_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.integer  "event_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "uid",        limit: 255
  end

  add_index "videos", ["event_id"], name: "index_videos_on_event_id", using: :btree

  add_foreign_key "events", "colleges"
  add_foreign_key "videos", "events"
end
