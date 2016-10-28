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

ActiveRecord::Schema.define(version: 20161028044001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["email_address"], name: "index_orders_on_email_address", using: :btree
    t.index ["order_id"], name: "index_orders_on_order_id", using: :btree
    t.index ["order_time"], name: "index_orders_on_order_time", using: :btree
    t.index ["owner_id"], name: "index_orders_on_owner_id", using: :btree
    t.index ["payment_status"], name: "index_orders_on_payment_status", using: :btree
    t.index ["shipping_city"], name: "index_orders_on_shipping_city", using: :btree
    t.index ["shipping_company"], name: "index_orders_on_shipping_company", using: :btree
    t.index ["shipping_country"], name: "index_orders_on_shipping_country", using: :btree
    t.index ["shipping_country_code"], name: "index_orders_on_shipping_country_code", using: :btree
    t.index ["shipping_postal_code"], name: "index_orders_on_shipping_postal_code", using: :btree
    t.index ["shipping_region_code"], name: "index_orders_on_shipping_region_code", using: :btree
    t.index ["shipping_status"], name: "index_orders_on_shipping_status", using: :btree
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
