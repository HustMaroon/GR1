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

ActiveRecord::Schema.define(version: 20170513194005) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "bonus", force: :cascade do |t|
    t.integer  "sclass_id",  limit: 4
    t.string   "condition",  limit: 255
    t.integer  "bonus",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "bonus", ["sclass_id"], name: "index_bonus_on_sclass_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "course_id",  limit: 255
    t.float    "term_ratio", limit: 24,  default: 0.7
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "sclass_id",   limit: 4
    t.string   "title",       limit: 255
    t.string   "file",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "documents", ["sclass_id"], name: "index_documents_on_sclass_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "learnings", force: :cascade do |t|
    t.integer  "student_id", limit: 4
    t.integer  "sclass_id",  limit: 4
    t.integer  "group_id",   limit: 4
    t.float    "term_point", limit: 24, default: 0.0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "learnings", ["group_id"], name: "index_learnings_on_group_id", using: :btree
  add_index "learnings", ["sclass_id"], name: "index_learnings_on_sclass_id", using: :btree
  add_index "learnings", ["student_id"], name: "index_learnings_on_student_id", using: :btree

  create_table "missed_logs", force: :cascade do |t|
    t.integer  "student_id",  limit: 4
    t.integer  "schedule_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "missed_logs", ["schedule_id"], name: "index_missed_logs_on_schedule_id", using: :btree
  add_index "missed_logs", ["student_id"], name: "index_missed_logs_on_student_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "user_type",  limit: 4
    t.string   "content",    limit: 255
    t.string   "link",       limit: 255
    t.boolean  "read",                   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "points", force: :cascade do |t|
    t.integer  "score_table_id", limit: 4
    t.integer  "student_id",     limit: 4
    t.float    "value",          limit: 24,  default: 0.0
    t.string   "note",           limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "points", ["score_table_id"], name: "index_points_on_score_table_id", using: :btree
  add_index "points", ["student_id"], name: "index_points_on_student_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "topic_id",   limit: 4
    t.integer  "group_id",   limit: 4
    t.string   "file",       limit: 255
    t.float    "score",      limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "reports", ["group_id"], name: "index_reports_on_group_id", using: :btree
  add_index "reports", ["topic_id"], name: "index_reports_on_topic_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "sclass_id",    limit: 4
    t.date     "date"
    t.text     "content",      limit: 65535
    t.integer  "first_lesson", limit: 4
    t.integer  "last_lesson",  limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "schedules", ["sclass_id"], name: "index_schedules_on_sclass_id", using: :btree

  create_table "sclasses", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.integer  "teacher_id", limit: 4
    t.string   "sclass_id",  limit: 255
    t.string   "room",       limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sclasses", ["course_id"], name: "index_sclasses_on_course_id", using: :btree
  add_index "sclasses", ["teacher_id"], name: "index_sclasses_on_teacher_id", using: :btree

  create_table "score_components", force: :cascade do |t|
    t.integer  "sclass_id",  limit: 4
    t.string   "content",    limit: 255
    t.integer  "ratio",      limit: 4,   default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "score_tables", force: :cascade do |t|
    t.integer  "score_component_id", limit: 4
    t.string   "title",              limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "score_tables", ["score_component_id"], name: "index_score_tables_on_score_component_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "std_id",          limit: 255
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.date     "last_reminded"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.date     "last_reminded"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "sclass_id",  limit: 4
    t.string   "title",      limit: 255
    t.datetime "deadline"
    t.integer  "ratio",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "topics", ["sclass_id"], name: "index_topics_on_sclass_id", using: :btree

  add_foreign_key "bonus", "sclasses"
  add_foreign_key "documents", "sclasses"
  add_foreign_key "learnings", "sclasses"
  add_foreign_key "learnings", "students"
  add_foreign_key "missed_logs", "schedules"
  add_foreign_key "missed_logs", "students"
  add_foreign_key "points", "score_tables"
  add_foreign_key "points", "students"
  add_foreign_key "reports", "groups"
  add_foreign_key "reports", "topics"
  add_foreign_key "schedules", "sclasses"
  add_foreign_key "sclasses", "courses"
  add_foreign_key "sclasses", "teachers"
  add_foreign_key "score_tables", "score_components"
  add_foreign_key "topics", "sclasses"
end
