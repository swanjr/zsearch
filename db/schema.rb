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

ActiveRecord::Schema.define(version: 2020_02_07_213222) do

  create_table "organizations", primary_key: "_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "url", null: false
    t.string "external_id", null: false
    t.string "name", null: false
    t.text "domain_names"
    t.datetime "created_at", null: false
    t.string "details"
    t.boolean "shared_tickets"
    t.text "tags"
    t.index ["external_id"], name: "index_organizations_on_external_id", unique: true
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["url"], name: "index_organizations_on_url", unique: true
  end

  create_table "tickets", primary_key: "_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "url", null: false
    t.string "external_id", null: false
    t.datetime "created_at", null: false
    t.string "type"
    t.string "subject", null: false
    t.text "description"
    t.string "priority"
    t.string "status"
    t.integer "submitter_id"
    t.integer "assignee_id"
    t.integer "organization_id"
    t.text "tags"
    t.boolean "has_incidents"
    t.datetime "due_at"
    t.string "via"
    t.index ["assignee_id"], name: "index_tickets_on_assignee_id"
    t.index ["external_id"], name: "index_tickets_on_external_id", unique: true
    t.index ["organization_id"], name: "index_tickets_on_organization_id"
    t.index ["submitter_id"], name: "index_tickets_on_submitter_id"
    t.index ["url"], name: "index_tickets_on_url", unique: true
  end

  create_table "users", primary_key: "_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "url", null: false
    t.string "external_id", null: false
    t.string "name", null: false
    t.string "alias"
    t.datetime "created_at", null: false
    t.boolean "active"
    t.boolean "verified"
    t.boolean "shared"
    t.string "locale"
    t.string "timezone"
    t.datetime "last_login_at"
    t.string "email"
    t.string "phone"
    t.string "signature"
    t.integer "organization_id"
    t.text "tags"
    t.boolean "suspended"
    t.string "role"
    t.index ["external_id"], name: "index_users_on_external_id", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["url"], name: "index_users_on_url", unique: true
  end

  add_foreign_key "tickets", "organizations", primary_key: "_id"
  add_foreign_key "tickets", "users", column: "assignee_id", primary_key: "_id"
  add_foreign_key "tickets", "users", column: "submitter_id", primary_key: "_id"
  add_foreign_key "users", "organizations", primary_key: "_id"
end
