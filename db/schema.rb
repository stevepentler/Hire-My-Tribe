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

ActiveRecord::Schema.define(version: 20160114031508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contractors", force: :cascade do |t|
    t.string   "company_name",    default: ""
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "bio",             default: ""
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "developers", force: :cascade do |t|
    t.string   "name"
    t.string   "profile_picture"
    t.float    "rate"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "status",          default: "available"
    t.integer  "specialty_id"
  end

  add_index "developers", ["specialty_id"], name: "index_developers_on_specialty_id", using: :btree

  create_table "project_developers", force: :cascade do |t|
    t.integer "project_id"
    t.integer "developer_id"
  end

  add_index "project_developers", ["developer_id"], name: "index_project_developers_on_developer_id", using: :btree
  add_index "project_developers", ["project_id"], name: "index_project_developers_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "status",        default: 0
    t.integer  "total"
    t.integer  "contractor_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "projects", ["contractor_id"], name: "index_projects_on_contractor_id", using: :btree

  create_table "specialties", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "url_name"
  end

  add_foreign_key "developers", "specialties"
  add_foreign_key "project_developers", "developers"
  add_foreign_key "project_developers", "projects"
  add_foreign_key "projects", "contractors"
end
