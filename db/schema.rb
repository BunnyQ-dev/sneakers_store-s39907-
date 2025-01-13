# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_12_162711) do
  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.integer "sneaker_id", null: false
    t.string "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sneaker_id"], name: "index_reviews_on_sneaker_id"
  end

  create_table "sneakers", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.text "description"
    t.string "size"
    t.string "color"
    t.integer "brand_id", null: false
    t.integer "category_id", null: false
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_sneakers_on_brand_id"
    t.index ["category_id"], name: "index_sneakers_on_category_id"
  end

  add_foreign_key "reviews", "sneakers"
  add_foreign_key "sneakers", "brands"
  add_foreign_key "sneakers", "categories"
end
