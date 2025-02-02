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

ActiveRecord::Schema.define(version: 2021_02_03_194436) do

  create_table "lakatan_tasks", force: :cascade do |t|
    t.string "name"
    t.string "goal"
    t.string "raffle_type"
    t.integer "label_id"
    t.bigint "team_id"
    t.integer "user_minimum"
    t.json "dynamic_attributes", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lakatan_teams", force: :cascade do |t|
    t.string "name"
    t.string "purpose"
    t.text "task_ids"
    t.text "user_ids"
    t.json "dynamic_attributes", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lakatan_users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "slack_id"
    t.string "personal_interview_url"
    t.string "technical_interview_url"
    t.integer "last_org"
    t.text "team_ids"
    t.json "dynamic_attributes", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
