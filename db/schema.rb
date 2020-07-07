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

ActiveRecord::Schema.define(version: 2020_07_04_190635) do

  create_table "private_shops", force: :cascade do |t|
    t.string "shopify_domain"
    t.string "encrypted_api_key"
    t.string "encrypted_api_key_iv"
    t.string "encrypted_password"
    t.string "encrypted_password_iv"
    t.string "encrypted_shared_secret"
    t.string "encrypted_shared_secret_iv"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["encrypted_api_key_iv"], name: "index_private_shops_on_encrypted_api_key_iv"
    t.index ["encrypted_password_iv"], name: "index_private_shops_on_encrypted_password_iv"
    t.index ["encrypted_shared_secret_iv"], name: "index_private_shops_on_encrypted_shared_secret_iv"
    t.index ["shopify_domain"], name: "index_private_shops_on_shopify_domain"
  end

end
