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

ActiveRecord::Schema.define(version: 20140609011923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "districts", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.boolean  "is_park"
    t.string   "credit"
    t.string   "photo_url"
    t.string   "flickr_search_term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eateries", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
