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

ActiveRecord::Schema.define(version: 20170925125925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "beneficiaries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "relation"
    t.integer "allocated_percentage"
    t.date "birthday"
    t.uuid "insurance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insurance_id"], name: "index_beneficiaries_on_insurance_id"
  end

  create_table "counties", force: :cascade do |t|
    t.integer "state_id"
    t.string "abbr"
    t.string "name"
    t.string "county_seat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_counties_on_name"
    t.index ["state_id"], name: "index_counties_on_state_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "insurances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "tobacco_product"
    t.boolean "health_condition"
    t.integer "gender"
    t.date "birthday"
    t.integer "height"
    t.integer "weight"
    t.integer "coverage_amount"
    t.integer "payment_frequency"
    t.boolean "terms_and_services"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aasm_state"
    t.integer "coverage_age"
    t.decimal "coverage_payment", precision: 15, scale: 2
    t.string "stripe_customer"
    t.string "stripe_plan_id"
    t.jsonb "stripe_response"
    t.jsonb "docusign_response"
    t.string "policy"
    t.string "driving_license"
    t.jsonb "stripe_plan_response"
    t.jsonb "stripe_subscription_response"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "phone_number"
    t.string "product"
    t.boolean "alcohol"
    t.boolean "blood"
    t.boolean "cholesterol"
    t.boolean "driving"
    t.boolean "family_history"
    t.boolean "occupation"
    t.index ["user_id"], name: "index_insurances_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "abbr", limit: 2
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abbr"], name: "index_states_on_abbr"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "state"
    t.string "city"
    t.string "zipcode"
    t.string "phone_number"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zipcodes", force: :cascade do |t|
    t.string "code"
    t.string "city"
    t.integer "state_id"
    t.integer "county_id"
    t.string "area_code"
    t.decimal "lat", precision: 15, scale: 10
    t.decimal "lon", precision: 15, scale: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "activate", default: true
    t.index ["code"], name: "index_zipcodes_on_code"
    t.index ["county_id"], name: "index_zipcodes_on_county_id"
    t.index ["lat", "lon"], name: "index_zipcodes_on_lat_and_lon"
    t.index ["state_id"], name: "index_zipcodes_on_state_id"
  end

  add_foreign_key "beneficiaries", "insurances"
  add_foreign_key "insurances", "users"
end
