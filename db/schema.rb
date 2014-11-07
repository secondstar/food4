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

ActiveRecord::Schema.define(version: 20141107153054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addendums", force: true do |t|
    t.string   "source"
    t.string   "href"
    t.text     "description"
    t.string   "category"
    t.integer  "portrayal_id"
    t.string   "portrayal_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived_at"
  end

  create_table "disneyfoodblog_com_reviews", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "archived_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "service"
    t.string   "type_of_food"
    t.text     "location"
    t.string   "disney_dining_plan"
    t.string   "tables_in_wonderland"
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

  create_table "districts", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.boolean  "is_park"
    t.string   "credit"
    t.string   "photo_url"
    t.string   "flickr_search_term"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "districts", ["name"], name: "index_districts_on_name", using: :btree

  create_table "eateries", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "adult_dinner_menu_url"
    t.string   "wine_list"
    t.string   "dinner_hours"
    t.string   "child_breakfast_menu_url"
    t.string   "breakfast_hours"
    t.string   "adult_breakfast_menu_url"
    t.string   "requires_pre_payment"
    t.string   "dress"
    t.string   "overall_rating"
    t.string   "counter_quality_rating"
    t.string   "awards"
    t.string   "requires_credit_card"
    t.string   "category_code"
    t.string   "phone_number"
    t.string   "parking"
    t.string   "lunch_hours"
    t.string   "counter_value_rating"
    t.string   "child_dinner_menu_url"
    t.string   "cuisine"
    t.string   "bar"
    t.string   "thumbs_up"
    t.string   "table_quality_rating"
    t.string   "service_rating"
    t.string   "extinct_on"
    t.string   "entree_range"
    t.string   "cost_code"
    t.string   "adult_lunch_menu_url"
    t.string   "table_value_rating"
    t.string   "opened_on"
    t.string   "friendliness_rating"
    t.string   "portion_size"
    t.integer  "district_id"
    t.string   "credit"
    t.string   "disney_permalink"
    t.string   "code"
    t.string   "short_name"
    t.string   "dbf_permalink"
    t.string   "service"
    t.string   "type_of_food"
    t.string   "disney_dining_plan"
    t.string   "tables_in_wonderland"
    t.text     "menu"
    t.text     "important_info"
    t.text     "famous_dishes"
    t.text     "you_might_also_like"
    t.text     "dfb_posts"
    t.string   "dfb_permalink"
    t.string   "location"
    t.string   "flickr_search_term"
    t.text     "touring_plans_permalink"
    t.string   "accepts_tiw"
    t.string   "kosher_available"
    t.string   "accepts_reservations"
    t.text     "house_specialties"
    t.text     "location_details"
    t.datetime "published_on"
    t.string   "when_to_go"
    t.string   "child_lunch_menu_url"
    t.integer  "dinable_id"
    t.string   "dinable_type"
  end

  create_table "photos", force: true do |t|
    t.text     "url"
    t.string   "farm"
    t.string   "server"
    t.string   "owner"
    t.integer  "photogenic_id"
    t.string   "photogenic_type"
    t.string   "flickr_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.string   "secret"
  end

  add_index "photos", ["photogenic_id", "photogenic_type"], name: "index_photos_on_photogenic_id_and_photogenic_type", using: :btree

  create_table "snapshots", force: true do |t|
    t.integer  "eatery_id"
    t.string   "review_type"
    t.integer  "review_id"
    t.text     "review_permalink"
    t.boolean  "review_permalink_is_different_than_eatery_permalink", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "snapshots", ["eatery_id"], name: "index_snapshots_on_eatery_id", using: :btree
  add_index "snapshots", ["review_id"], name: "index_snapshots_on_review_id", using: :btree

  create_table "touring_plans_com_reviews", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived_at"
    t.integer  "district_id"
    t.string   "service_rating"
    t.boolean  "requires_credit_card"
    t.boolean  "kosher_available"
    t.string   "disney_permalink"
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
    t.string   "portion_size"
    t.text     "lunch_hours"
    t.text     "extinct_on"
    t.string   "bar"
    t.string   "short_name"
    t.text     "entree_range"
    t.string   "code"
    t.text     "parking"
    t.string   "cost_code"
    t.text     "child_dinner_menu_url"
    t.string   "table_quality_rating"
    t.string   "counter_quality_rating"
    t.string   "breakfast_hours"
    t.string   "thumbs_up"
    t.string   "overall_rating"
    t.string   "counter_value_rating"
    t.text     "adult_dinner_menu_url"
    t.string   "phone_number"
    t.string   "opened_on"
    t.text     "adult_breakfast_menu_url"
    t.string   "table_value_rating"
    t.text     "awards"
    t.string   "friendliness_rating"
    t.string   "cuisine"
    t.string   "category_code"
    t.string   "dress"
    t.integer  "dinable_id"
    t.string   "dinable_type"
  end

end
