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

ActiveRecord::Schema.define(version: 20131010142932) do

  create_table "opt_ins", force: true do |t|
    t.string   "email"
    t.string   "mobile"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "permission_type"
    t.string   "channel"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opt_ins", ["channel", "company_name"], name: "index_opt_ins_on_channel_and_company_name", unique: true

end
