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

ActiveRecord::Schema.define(version: 2019_07_01_030640) do

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_brands_on_category_id"
    t.index ["name"], name: "index_brands_on_name"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "credits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "card_number", null: false
    t.integer "validated_date_month", default: 0, null: false
    t.integer "validated_date_year", default: 0, null: false
    t.integer "security_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "fk_rails_9001739776"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_name", null: false
    t.text "product_introduction"
    t.bigint "category_id"
    t.bigint "products_size_id"
    t.bigint "brand_id"
    t.integer "product_status", default: 0, null: false
    t.integer "delivery_charge", default: 0, null: false
    t.integer "delivery_area", default: 0, null: false
    t.string "price", null: false
    t.integer "delivery_days", default: 0, null: false
    t.integer "delivery_method", default: 0, null: false
    t.integer "trading_state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "fk_rails_f3b4d49caa"
    t.index ["category_id"], name: "fk_rails_fb915499a4"
    t.index ["product_name"], name: "index_products_on_product_name"
    t.index ["products_size_id"], name: "fk_rails_9c56f738b7"
  end

  create_table "products_sizes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "size", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["size"], name: "index_products_sizes_on_size"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.integer "birthdate_year", null: false
    t.integer "birthdate_month", null: false
    t.integer "birthdate_day", null: false
    t.integer "phone_number", null: false
    t.string "address_last_name", null: false
    t.string "address_first_name", null: false
    t.string "address_last_name_kana", null: false
    t.string "address_first_name_kana", null: false
    t.string "address_number", null: false
    t.integer "address_prefecture", default: 0, null: false
    t.string "address_name", null: false
    t.string "address_block", null: false
    t.string "address_building"
    t.integer "address_phone_number"
    t.text "introduce"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "brands", "categories"
  add_foreign_key "credits", "users"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "products_sizes"
end