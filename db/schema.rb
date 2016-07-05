# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160610230007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "currency",                         null: false
    t.integer  "balance",    limit: 8, default: 0, null: false
    t.integer  "wallet_id",                        null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "accounts", ["currency"], name: "index_accounts_on_currency", using: :btree
  add_index "accounts", ["wallet_id"], name: "index_accounts_on_wallet_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "currency",              null: false
    t.string   "address",               null: false
    t.string   "encrypted_private_key", null: false
    t.integer  "account_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "addresses", ["account_id"], name: "index_addresses_on_account_id", using: :btree
  add_index "addresses", ["address"], name: "index_addresses_on_address", using: :btree
  add_index "addresses", ["currency"], name: "index_addresses_on_currency", using: :btree

  create_table "payments", force: :cascade do |t|
    t.string   "type",                                     null: false
    t.string   "currency",                                 null: false
    t.string   "state",                                    null: false
    t.integer  "amount",         limit: 8,                 null: false
    t.boolean  "external",                 default: false, null: false
    t.integer  "transaction_id",                           null: false
    t.integer  "account_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "payments", ["account_id"], name: "index_payments_on_account_id", using: :btree
  add_index "payments", ["state"], name: "index_payments_on_state", using: :btree
  add_index "payments", ["transaction_id"], name: "index_payments_on_transaction_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.string   "state",      null: false
    t.integer  "wallet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["state"], name: "index_transactions_on_state", using: :btree
  add_index "transactions", ["wallet_id"], name: "index_transactions_on_wallet_id", using: :btree

  create_table "wallets", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
