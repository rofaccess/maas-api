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

ActiveRecord::Schema[7.0].define(version: 2022_11_18_212532) do
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

  create_table "time_block_employee_assignments", force: :cascade do |t|
    t.bigint "time_block_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_time_block_employee_assignments_on_employee_id"
    t.index ["time_block_id", "employee_id", "start_at", "end_at"], name: "index_ti_bl_id_em_id_st_at_en_at", unique: true
    t.index ["time_block_id"], name: "index_time_block_employee_assignments_on_time_block_id"
  end

  create_table "time_block_service_assignments", force: :cascade do |t|
    t.bigint "time_block_id", null: false
    t.bigint "monitored_service_id", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monitored_service_id"], name: "index_time_block_service_assignments_on_monitored_service_id"
    t.index ["time_block_id", "monitored_service_id", "start_at", "end_at"], name: "index_ti_bl_id_mo_se_id_st_at_en_at", unique: true
    t.index ["time_block_id"], name: "index_time_block_service_assignments_on_time_block_id"
  end

  create_table "time_blocks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_time_blocks_on_name", unique: true
  end

  add_foreign_key "monitored_services", "companies"
  add_foreign_key "time_block_employee_assignments", "employees"
  add_foreign_key "time_block_employee_assignments", "time_blocks"
  add_foreign_key "time_block_service_assignments", "monitored_services"
  add_foreign_key "time_block_service_assignments", "time_blocks"
end
