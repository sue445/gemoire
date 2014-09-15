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

ActiveRecord::Schema.define(version: 20140915105726) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name",                              null: false
    t.string   "branch",         default: "master", null: false
    t.string   "remote_url",                        null: false
    t.string   "commit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "repository_url",                    null: false
  end

  add_index "projects", ["name"], name: "index_projects_on_name", unique: true
  add_index "projects", ["remote_url"], name: "index_projects_on_remote_url"

end
