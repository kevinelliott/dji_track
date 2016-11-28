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

ActiveRecord::Schema.define(version: 20161128210739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title",                          null: false
    t.text     "body"
    t.datetime "published_at"
    t.string   "status",       default: "draft", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.index ["published_at"], name: "index_articles_on_published_at", using: :btree
    t.index ["status"], name: "index_articles_on_status", using: :btree
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name",                                            null: false
    t.string   "code",                                            null: false
    t.text     "description"
    t.string   "website"
    t.string   "support_email"
    t.string   "support_website"
    t.string   "logo_url"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "common_name",     default: "MISSING COMMON NAME", null: false
    t.index ["code"], name: "index_manufacturers_on_code", using: :btree
    t.index ["common_name"], name: "index_manufacturers_on_common_name", using: :btree
    t.index ["name"], name: "index_manufacturers_on_name", using: :btree
  end

  create_table "merchants", force: :cascade do |t|
    t.string   "name",                                          null: false
    t.text     "description"
    t.string   "website"
    t.string   "referral_code"
    t.string   "status",        default: "pending",             null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "common_name",   default: "MISSING COMMON NAME", null: false
    t.index ["common_name"], name: "index_merchants_on_common_name", using: :btree
    t.index ["status"], name: "index_merchants_on_status", using: :btree
  end

  create_table "order_state_logs", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "column",     null: false
    t.string   "from"
    t.string   "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column"], name: "index_order_state_logs_on_column", using: :btree
    t.index ["from"], name: "index_order_state_logs_on_from", using: :btree
    t.index ["order_id"], name: "index_order_state_logs_on_order_id", using: :btree
    t.index ["to"], name: "index_order_state_logs_on_to", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "order_id"
    t.datetime "order_time"
    t.string   "payment_status"
    t.string   "payment_method"
    t.string   "payment_total"
    t.string   "shipping_address"
    t.string   "shipping_address_line_2"
    t.string   "shipping_city"
    t.string   "shipping_region_code"
    t.string   "shipping_postal_code"
    t.string   "shipping_country"
    t.string   "shipping_country_code"
    t.string   "shipping_phone"
    t.string   "shipping_status"
    t.string   "shipping_company"
    t.string   "tracking_number"
    t.string   "email_address"
    t.string   "access_key"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.datetime "last_changed_at"
    t.string   "dji_username"
    t.string   "phone_tail"
    t.integer  "merchant_id",                  default: 1,         null: false
    t.datetime "estimated_delivery_at"
    t.string   "delivery_status",              default: "pending"
    t.datetime "delivered_at"
    t.integer  "product_id"
    t.boolean  "dji_lookup_success",           default: false,     null: false
    t.string   "dji_lookup_error_code"
    t.string   "dji_lookup_error_reason_code"
    t.string   "safe_id",                                          null: false
    t.index ["delivered_at"], name: "index_orders_on_delivered_at", using: :btree
    t.index ["delivery_status"], name: "index_orders_on_delivery_status", using: :btree
    t.index ["dji_lookup_error_code"], name: "index_orders_on_dji_lookup_error_code", using: :btree
    t.index ["dji_lookup_error_reason_code"], name: "index_orders_on_dji_lookup_error_reason_code", using: :btree
    t.index ["dji_lookup_success"], name: "index_orders_on_dji_lookup_success", using: :btree
    t.index ["dji_username"], name: "index_orders_on_dji_username", using: :btree
    t.index ["email_address"], name: "index_orders_on_email_address", using: :btree
    t.index ["estimated_delivery_at"], name: "index_orders_on_estimated_delivery_at", using: :btree
    t.index ["last_changed_at"], name: "index_orders_on_last_changed_at", using: :btree
    t.index ["merchant_id"], name: "index_orders_on_merchant_id", using: :btree
    t.index ["order_id"], name: "index_orders_on_order_id", using: :btree
    t.index ["order_time"], name: "index_orders_on_order_time", using: :btree
    t.index ["owner_id"], name: "index_orders_on_owner_id", using: :btree
    t.index ["payment_status"], name: "index_orders_on_payment_status", using: :btree
    t.index ["product_id"], name: "index_orders_on_product_id", using: :btree
    t.index ["safe_id"], name: "index_orders_on_safe_id", unique: true, using: :btree
    t.index ["shipping_city"], name: "index_orders_on_shipping_city", using: :btree
    t.index ["shipping_company"], name: "index_orders_on_shipping_company", using: :btree
    t.index ["shipping_country"], name: "index_orders_on_shipping_country", using: :btree
    t.index ["shipping_country_code"], name: "index_orders_on_shipping_country_code", using: :btree
    t.index ["shipping_postal_code"], name: "index_orders_on_shipping_postal_code", using: :btree
    t.index ["shipping_region_code"], name: "index_orders_on_shipping_region_code", using: :btree
    t.index ["shipping_status"], name: "index_orders_on_shipping_status", using: :btree
  end

  create_table "product_families", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name",                                null: false
    t.string   "description"
    t.string   "logo_url"
    t.string   "website"
    t.string   "status",          default: "pending", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["manufacturer_id"], name: "index_product_families_on_manufacturer_id", using: :btree
    t.index ["status"], name: "index_product_families_on_status", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.integer  "manufacturer_id",                       null: false
    t.string   "name",                                  null: false
    t.string   "code",                                  null: false
    t.text     "description"
    t.string   "logo_url"
    t.string   "website"
    t.string   "upc"
    t.string   "asin"
    t.string   "status",            default: "pending", null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "dji_store_url"
    t.integer  "product_family_id"
    t.boolean  "accessory",         default: false,     null: false
    t.index ["accessory"], name: "index_products_on_accessory", using: :btree
    t.index ["code"], name: "index_products_on_code", using: :btree
    t.index ["manufacturer_id"], name: "index_products_on_manufacturer_id", using: :btree
    t.index ["name"], name: "index_products_on_name", using: :btree
    t.index ["product_family_id"], name: "index_products_on_product_family_id", using: :btree
    t.index ["status"], name: "index_products_on_status", using: :btree
  end

  create_table "streaming_sites", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "code",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "website"
    t.string   "logo_url"
    t.index ["code"], name: "index_streaming_sites_on_code", using: :btree
    t.index ["name"], name: "index_streaming_sites_on_name", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "terms", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_terms_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.string   "username",                            null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "streaming_site_id"
    t.string   "title",                                            null: false
    t.text     "summary",                                          null: false
    t.text     "description"
    t.string   "url",                                              null: false
    t.string   "channel_name"
    t.string   "channel_url"
    t.integer  "user_id"
    t.string   "status",                default: "pending-review", null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.datetime "published_at"
    t.string   "thumbnail_url_small"
    t.string   "thumbnail_url_medium"
    t.string   "thumbnail_url_large"
    t.string   "embed_url"
    t.text     "embed_code"
    t.datetime "provider_published_at"
    t.integer  "duration"
    t.index ["channel_name"], name: "index_videos_on_channel_name", using: :btree
    t.index ["published_at"], name: "index_videos_on_published_at", using: :btree
    t.index ["status"], name: "index_videos_on_status", using: :btree
    t.index ["streaming_site_id"], name: "index_videos_on_streaming_site_id", using: :btree
    t.index ["user_id"], name: "index_videos_on_user_id", using: :btree
  end

  add_foreign_key "articles", "users"
  add_foreign_key "order_state_logs", "orders"
  add_foreign_key "orders", "products"
  add_foreign_key "product_families", "manufacturers"
  add_foreign_key "products", "manufacturers"
  add_foreign_key "products", "product_families"
  add_foreign_key "videos", "streaming_sites"
  add_foreign_key "videos", "users"
end
