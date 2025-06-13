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

ActiveRecord::Schema[7.0].define(version: 2025_06_06_182713) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_postgresql_files", force: :cascade do |t|
    t.oid "oid"
    t.string "key"
    t.index ["key"], name: "index_active_storage_postgresql_files_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "billing_infos", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "contact_id"
    t.bigint "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_billing_infos_on_contact_id"
    t.index ["transaction_id"], name: "index_billing_infos_on_transaction_id"
    t.index ["user_id"], name: "index_billing_infos_on_user_id"
  end

  create_table "color_settings", force: :cascade do |t|
    t.string "primary_color", default: "#007e7c"
    t.string "secondary_color", default: "#d3d7de"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "currency_name"
    t.string "currency_code"
    t.string "external_id"
    t.integer "tax_rate", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "iso3"
    t.string "french_name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_fresk_settings", force: :cascade do |t|
    t.string "non_profit_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_fresk_smtp_settings", force: :cascade do |t|
    t.string "host", null: false
    t.integer "port", default: 587, null: false
    t.string "username", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "training_session_id", null: false
    t.string "status", default: "PENDING", null: false
    t.datetime "presence_recorded_at", precision: nil
    t.bigint "animator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animator_id"], name: "index_participations_on_animator_id"
    t.index ["training_session_id"], name: "index_participations_on_training_session_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "product_configuration_sessions", force: :cascade do |t|
    t.bigint "product_configuration_id", null: false
    t.bigint "training_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_configuration_id"], name: "index_prod_config_sess_on_prod_config_id"
    t.index ["training_session_id"], name: "index_prod_config_sess_on_train_sess_id"
  end

  create_table "product_configurations", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "country_id", null: false
    t.integer "before_tax_price_cents"
    t.integer "tax_cents"
    t.integer "after_tax_price_cents"
    t.decimal "tax_rate", precision: 3, scale: 1
    t.string "currency"
    t.string "display_name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "country_id"], name: "index_product_configurations_on_product_id_and_country_id", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "category", null: false
    t.boolean "charged", default: false, null: false
    t.boolean "price_modifiable", default: false, null: false
    t.string "audience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smtp_settings", force: :cascade do |t|
    t.integer "port", null: false
    t.string "domain", null: false
    t.string "authentication", default: "plain", null: false
    t.string "user_name", null: false
    t.string "encrypted_password", null: false
    t.string "encrypted_password_iv", null: false
    t.boolean "enable_starttls_auto", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "from_address"
  end

  create_table "training_sessions", force: :cascade do |t|
    t.text "description"
    t.date "date", null: false
    t.datetime "start_time", precision: nil, null: false
    t.datetime "end_time", precision: nil, null: false
    t.string "category", null: false
    t.string "format", null: false
    t.string "connexion_url"
    t.string "room"
    t.string "street"
    t.string "city"
    t.string "zip"
    t.integer "capacity", default: 0
    t.boolean "public"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "time_zone", default: "Paris", null: false
    t.integer "country_id", null: false
    t.integer "created_by_user_id", default: 1, null: false
    t.text "session_info"
    t.integer "language_id", null: false
    t.float "latitude"
    t.float "longitude"
    t.text "animator_session_info"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "participation_id"
    t.bigint "product_configuration_id"
    t.text "stripe_response"
    t.string "status"
    t.integer "before_tax_price_cents"
    t.integer "tax_cents"
    t.integer "after_tax_price_cents"
    t.string "currency"
    t.string "payment_intent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participation_id"], name: "index_transactions_on_participation_id"
    t.index ["product_configuration_id"], name: "index_transactions_on_product_configuration_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.string "token", default: -> { "uuid_generate_v4()" }, null: false
    t.string "refresh_token", default: -> { "uuid_generate_v4()" }, null: false
    t.string "language", default: "fr", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["refresh_token"], name: "index_users_on_refresh_token", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "billing_infos", "transactions"
  add_foreign_key "billing_infos", "users"
  add_foreign_key "billing_infos", "users", column: "contact_id"
  add_foreign_key "participations", "users", column: "animator_id"
  add_foreign_key "product_configuration_sessions", "product_configurations"
  add_foreign_key "product_configuration_sessions", "training_sessions"
  add_foreign_key "transactions", "participations"
  add_foreign_key "transactions", "product_configurations"
end
