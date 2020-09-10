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

ActiveRecord::Schema.define(version: 2020_09_10_141026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exports", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.string "sku"
    t.string "url"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uniqueid"
    t.string "title"
    t.string "intro"
    t.string "mainimage"
    t.string "image1"
    t.string "image2"
    t.string "image3"
    t.string "level"
    t.string "time"
    t.string "how_to_make"
    t.string "shopping_list"
    t.string "what_youll_need"
    t.string "tip"
    t.string "template"
    t.string "tags"
    t.string "supervision"
    t.string "products"
    t.string "categories"
  end

end
