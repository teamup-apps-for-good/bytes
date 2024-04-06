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

ActiveRecord::Schema[7.1].define(version: 2024_04_06_201908) do
  create_table "credit_pools", force: :cascade do |t|
    t.integer "credits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "school_name"
    t.string "email_suffix"
    t.string "logo_url"
    t.string "id_name"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "uid"
    t.date "date"
    t.time "time"
    t.string "location"
    t.boolean "recurring"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
    t.string "accepted_uid"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "uid"
    t.string "transaction_type"
    t.datetime "time"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "credit_pool_id"
    t.index ["id"], name: "index_transactions_on_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "name"
    t.string "email"
    t.integer "credits"
    t.string "user_type"
    t.date "date_joined"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

end
