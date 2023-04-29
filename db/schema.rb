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

ActiveRecord::Schema[7.0].define(version: 2023_04_29_022800) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "purchasing_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "supplier_id", null: false
    t.jsonb "pr_quantity"
    t.date "delivery_date"
    t.string "delivery_time_slot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_purchasing_requests_on_supplier_id"
    t.index ["user_id"], name: "index_purchasing_requests_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "storage_locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "capacity"
    t.string "temperature"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_storage_locations_on_restaurant_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "email"
    t.string "contact_full_name"
    t.string "contact_phone_number"
    t.string "contact_email"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "position"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wines", force: :cascade do |t|
    t.string "maker"
    t.string "country"
    t.integer "vintage"
    t.string "colour"
    t.string "region"
    t.string "appellation"
    t.string "volume"
    t.string "cuvee"
    t.string "tasting_notes"
    t.string "grape_variety"
    t.text "description"
    t.bigint "supplier_id", null: false
    t.float "unit_price"
    t.float "avg_price"
    t.float "selling_price"
    t.integer "quantity"
    t.float "cost"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_wines_on_restaurant_id"
    t.index ["supplier_id"], name: "index_wines_on_supplier_id"
  end

  add_foreign_key "purchasing_requests", "suppliers"
  add_foreign_key "purchasing_requests", "users"
  add_foreign_key "storage_locations", "restaurants"
  add_foreign_key "wines", "restaurants"
  add_foreign_key "wines", "suppliers"
end
