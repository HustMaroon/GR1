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

ActiveRecord::Schema.define(version: 20160506211541) do

  create_table "learnings", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "sclass_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "attendance",    default: 0
    t.float    "process_point", default: 0.0
    t.float    "term_point",    default: 0.0
    t.float    "avg_point",     default: 0.0
  end

  add_index "learnings", ["sclass_id"], name: "index_learnings_on_sclass_id"
  add_index "learnings", ["student_id"], name: "index_learnings_on_student_id"

  create_table "mini_works", force: :cascade do |t|
    t.string   "name"
    t.float    "ratio"
    t.integer  "sclass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mini_works", ["sclass_id"], name: "index_mini_works_on_sclass_id"

  create_table "sclasses", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sclass_id"
  end

  add_index "sclasses", ["subject_id"], name: "index_sclasses_on_subject_id"
  add_index "sclasses", ["teacher_id"], name: "index_sclasses_on_teacher_id"

  create_table "students", force: :cascade do |t|
    t.string   "std_id"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "sbj_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
