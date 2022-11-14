# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_14_191059) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "assigned_color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_employees_on_name", unique: true
  end

  create_table "monitored_services", force: :cascade do |t|
    t.string "name"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_monitored_services_on_company_id"
    t.index ["name"], name: "index_monitored_services_on_name", unique: true
  end

  create_table "weekly_monitoring_calendars", force: :cascade do |t|
    t.bigint "monitored_service_id", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monitored_service_id", "start_at", "end_at"], name: "index_mo_ser_id_st_at_en_at", unique: true
    t.index ["monitored_service_id"], name: "index_weekly_monitoring_calendars_on_monitored_service_id"
  end

  add_foreign_key "monitored_services", "companies"
  add_foreign_key "weekly_monitoring_calendars", "monitored_services"
end
