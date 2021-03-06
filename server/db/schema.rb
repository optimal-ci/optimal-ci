# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_06_112346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "builds", force: :cascade do |t|
    t.integer "total_files_count"
    t.string "ci"
    t.string "build_number"
    t.string "queue", default: [], array: true
    t.string "processed", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id"
    t.string "command"
    t.index ["build_number"], name: "index_builds_on_build_number"
    t.index ["project_id", "build_number"], name: "index_builds_on_project_id_and_build_number", unique: true
    t.index ["project_id"], name: "index_builds_on_project_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.bigint "build_id", null: false
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "index"
    t.integer "http_calls_count"
    t.float "http_calls_time"
    t.index ["build_id", "index"], name: "index_nodes_on_build_id_and_index", unique: true
    t.index ["build_id"], name: "index_nodes_on_build_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "files", default: {}, null: false
    t.index ["token"], name: "index_projects_on_token"
  end

  add_foreign_key "nodes", "builds"
end
