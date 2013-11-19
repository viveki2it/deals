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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111117161645) do

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "purchased_at"
    t.datetime "created_at"
    t.string   "time_zone"
  end

  create_table "coupons", :force => true do |t|
    t.integer  "deal_id"
    t.string   "number",     :limit => 20
    t.string   "status",     :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deal_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deals", :force => true do |t|
    t.string   "title"
    t.integer  "deal_type_id"
    t.float    "purchase_price"
    t.float    "credit_price"
    t.string   "status"
    t.date     "deal_date"
    t.datetime "expire_date"
    t.datetime "coupon_expire_date"
    t.text     "store_message"
    t.text     "description"
    t.string   "store_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "discount_price"
    t.string   "store_name"
    t.string   "store_image"
  end

  create_table "images", :force => true do |t|
    t.integer  "deal_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "user_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.string   "express_token"
    t.string   "express_payer_id"
    t.date     "card_expires_on"
    t.datetime "created_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_deals", :force => true do |t|
    t.integer "user_id"
    t.integer "deal_id"
    t.integer "cart_id"
    t.string  "coupon_number"
  end

  create_table "user_purchased_deals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "deal_id"
    t.string   "coupon_number"
    t.string   "purchased_type", :limit => 15
    t.datetime "created_at"
  end

  create_table "user_shared_deals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "deal_id"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",             :limit => 40
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "is_admin",                            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credits",                             :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
