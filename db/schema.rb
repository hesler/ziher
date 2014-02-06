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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140106210952) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.boolean  "is_expense"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "position"
    t.integer  "year"
    t.boolean  "is_one_percent", :default => false
  end

  create_table "entries", :force => true do |t|
    t.date     "date"
    t.string   "name"
    t.string   "document_number"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "journal_id"
    t.boolean  "is_expense"
    t.integer  "linked_entry_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups_units", :force => true do |t|
    t.integer "group_id"
    t.integer "unit_id"
  end

  create_table "inventory_entries", :force => true do |t|
    t.date     "date"
    t.string   "stock_number"
    t.string   "name"
    t.string   "document_number"
    t.string   "source"
    t.integer  "amount"
    t.boolean  "is_expense"
    t.decimal  "total_value",     :precision => 9, :scale => 2
    t.string   "comment"
    t.integer  "unit_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "items", :force => true do |t|
    t.decimal  "amount",             :precision => 9, :scale => 2
    t.decimal  "amount_one_percent", :precision => 9, :scale => 2
    t.integer  "entry_id"
    t.integer  "category_id"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  create_table "journal_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "is_default", :default => false
  end

  create_table "journals", :force => true do |t|
    t.integer  "year"
    t.integer  "unit_id"
    t.integer  "journal_type_id"
    t.datetime "created_at",                                                                 :null => false
    t.datetime "updated_at",                                                                 :null => false
    t.boolean  "is_open"
    t.decimal  "initial_balance",             :precision => 9, :scale => 2, :default => 0.0, :null => false
    t.decimal  "initial_balance_one_percent", :precision => 9, :scale => 2, :default => 0.0, :null => false
  end

  create_table "subgroups", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "subgroup_id"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_group_associations", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "can_view_entries",   :default => false
    t.boolean  "can_manage_entries", :default => false
    t.boolean  "can_close_journals", :default => false
    t.boolean  "can_manage_users",   :default => false
    t.boolean  "can_manage_units",   :default => false
    t.boolean  "can_manage_groups",  :default => false
  end

  create_table "user_unit_associations", :force => true do |t|
    t.integer "unit_id"
    t.integer "user_id"
    t.boolean "can_view_entries",   :default => false
    t.boolean "can_manage_entries", :default => false
    t.boolean "can_close_journals", :default => false
    t.boolean "can_manage_users",   :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "",    :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.boolean  "is_superadmin",                        :default => false
    t.boolean  "is_blocked",                           :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
