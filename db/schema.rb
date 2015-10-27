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

ActiveRecord::Schema.define(version: 20151027230303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addendums", force: :cascade do |t|
    t.string   "source",         limit: 255
    t.string   "href",           limit: 255
    t.text     "description"
    t.string   "category",       limit: 255
    t.integer  "portrayal_id"
    t.string   "portrayal_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived_at"
  end

  create_table "disneyfoodblog_com_reviews", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "permalink",            limit: 255
    t.datetime "archived_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "service",              limit: 255
    t.string   "type_of_food",         limit: 255
    t.text     "location"
    t.string   "disney_dining_plan",   limit: 255
    t.string   "tables_in_wonderland", limit: 255
    t.text     "menu"
    t.text     "important_info"
    t.text     "famous_dishes"
    t.text     "mentioned_in"
    t.text     "reviews"
    t.text     "you_might_also_like"
    t.text     "breakfast_items"
    t.text     "drinks"
    t.text     "special_treats"
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "permalink",          limit: 255
    t.boolean  "is_park"
    t.string   "credit",             limit: 255
    t.string   "photo_url",          limit: 255
    t.string   "flickr_search_term", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "districts", ["is_park"], name: "index_districts_on_is_park", using: :btree
  add_index "districts", ["name"], name: "index_districts_on_name", using: :btree

  create_table "eateries", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.string   "permalink",                limit: 255
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "adult_dinner_menu_url",    limit: 255
    t.string   "wine_list",                limit: 255
    t.string   "dinner_hours",             limit: 255
    t.string   "child_breakfast_menu_url", limit: 255
    t.string   "breakfast_hours",          limit: 255
    t.string   "adult_breakfast_menu_url", limit: 255
    t.string   "requires_pre_payment",     limit: 255
    t.string   "dress",                    limit: 255
    t.string   "overall_rating",           limit: 255
    t.string   "counter_quality_rating",   limit: 255
    t.string   "awards",                   limit: 255
    t.string   "requires_credit_card",     limit: 255
    t.string   "category_code",            limit: 255
    t.string   "phone_number",             limit: 255
    t.string   "parking",                  limit: 255
    t.string   "lunch_hours",              limit: 255
    t.string   "counter_value_rating",     limit: 255
    t.string   "child_dinner_menu_url",    limit: 255
    t.string   "cuisine",                  limit: 255
    t.string   "bar",                      limit: 255
    t.string   "thumbs_up",                limit: 255
    t.string   "table_quality_rating",     limit: 255
    t.string   "service_rating",           limit: 255
    t.string   "extinct_on",               limit: 255
    t.string   "entree_range",             limit: 255
    t.string   "cost_code",                limit: 255
    t.string   "adult_lunch_menu_url",     limit: 255
    t.string   "table_value_rating",       limit: 255
    t.string   "opened_on",                limit: 255
    t.string   "friendliness_rating",      limit: 255
    t.string   "portion_size",             limit: 255
    t.integer  "district_id"
    t.string   "credit",                   limit: 255
    t.string   "disney_permalink",         limit: 255
    t.string   "code",                     limit: 255
    t.string   "short_name",               limit: 255
    t.string   "dbf_permalink",            limit: 255
    t.string   "service",                  limit: 255
    t.string   "type_of_food",             limit: 255
    t.string   "disney_dining_plan",       limit: 255
    t.string   "tables_in_wonderland",     limit: 255
    t.text     "menu"
    t.text     "important_info"
    t.text     "famous_dishes"
    t.text     "you_might_also_like"
    t.text     "dfb_posts"
    t.string   "dfb_permalink",            limit: 255
    t.string   "location",                 limit: 255
    t.string   "flickr_search_term",       limit: 255
    t.text     "touring_plans_permalink"
    t.string   "accepts_tiw",              limit: 255
    t.string   "kosher_available",         limit: 255
    t.string   "accepts_reservations",     limit: 255
    t.text     "house_specialties"
    t.text     "location_details"
    t.datetime "published_on"
    t.string   "when_to_go",               limit: 255
    t.string   "child_lunch_menu_url",     limit: 255
    t.integer  "dinable_id"
    t.string   "dinable_type",             limit: 255
  end

  add_index "eateries", ["name", "type_of_food"], name: "index_eateries_on_name_and_type_of_food", using: :btree

  create_table "foursquare_reviews", force: :cascade do |t|
    t.string   "foursquare_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "address"
    t.string   "cross_street"
    t.string   "lat"
    t.string   "lng"
    t.string   "alt_venues"
    t.string   "searched_for"
    t.datetime "archived_at"
  end

  create_table "photos", force: :cascade do |t|
    t.text     "url"
    t.string   "farm",            limit: 255
    t.string   "server",          limit: 255
    t.string   "owner",           limit: 255
    t.integer  "photogenic_id"
    t.string   "photogenic_type", limit: 255
    t.string   "flickr_id",       limit: 255
    t.string   "title",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.string   "secret",          limit: 255
  end

  add_index "photos", ["photogenic_id", "photogenic_type"], name: "index_photos_on_photogenic_id_and_photogenic_type", using: :btree

  create_table "snapshots", force: :cascade do |t|
    t.integer  "eatery_id"
    t.string   "review_type",                                         limit: 255
    t.integer  "review_id"
    t.text     "review_permalink"
    t.boolean  "review_permalink_is_different_than_eatery_permalink",             default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "snapshots", ["eatery_id"], name: "index_snapshots_on_eatery_id", using: :btree
  add_index "snapshots", ["review_id"], name: "index_snapshots_on_review_id", using: :btree

  create_table "touring_plans_com_reviews", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.string   "permalink",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived_at"
    t.integer  "district_id"
    t.string   "service_rating",           limit: 255
    t.boolean  "requires_credit_card"
    t.boolean  "kosher_available"
    t.string   "disney_permalink",         limit: 255
    t.text     "child_breakfast_menu_url"
    t.boolean  "requires_pre_payment"
    t.text     "house_specialties"
    t.text     "dinner_hours"
    t.text     "adult_lunch_menu_url"
    t.boolean  "accepts_reservations"
    t.text     "when_to_go"
    t.text     "location_details"
    t.text     "child_lunch_menu_url"
    t.boolean  "accepts_tiw"
    t.text     "wine_list"
    t.string   "portion_size",             limit: 255
    t.text     "lunch_hours"
    t.text     "extinct_on"
    t.string   "bar",                      limit: 255
    t.string   "short_name",               limit: 255
    t.text     "entree_range"
    t.string   "code",                     limit: 255
    t.text     "parking"
    t.string   "cost_code",                limit: 255
    t.text     "child_dinner_menu_url"
    t.string   "table_quality_rating",     limit: 255
    t.string   "counter_quality_rating",   limit: 255
    t.string   "breakfast_hours",          limit: 255
    t.string   "thumbs_up",                limit: 255
    t.string   "overall_rating",           limit: 255
    t.string   "counter_value_rating",     limit: 255
    t.text     "adult_dinner_menu_url"
    t.string   "phone_number",             limit: 255
    t.string   "opened_on",                limit: 255
    t.text     "adult_breakfast_menu_url"
    t.string   "table_value_rating",       limit: 255
    t.text     "awards"
    t.string   "friendliness_rating",      limit: 255
    t.string   "cuisine",                  limit: 255
    t.string   "category_code",            limit: 255
    t.string   "dress",                    limit: 255
    t.integer  "dinable_id"
    t.string   "dinable_type",             limit: 255
  end

end
