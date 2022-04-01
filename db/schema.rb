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

ActiveRecord::Schema[7.0].define(version: 2022_04_01_192005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payments", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "amount"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.string "description"
    t.string "emoji"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_purchases", force: :cascade do |t|
    t.bigint "purchase_id"
    t.bigint "user_id"
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_id"], name: "index_user_purchases_on_purchase_id"
    t.index ["user_id"], name: "index_user_purchases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "payments", "users", column: "receiver_id"
  add_foreign_key "payments", "users", column: "sender_id"
  add_foreign_key "purchases", "users"
  add_foreign_key "user_purchases", "purchases"
  add_foreign_key "user_purchases", "users"
end
