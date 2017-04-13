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

ActiveRecord::Schema.define(version: 20170413035237) do

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.text     "content"
    t.boolean  "correct",     default: false
    t.string   "image"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "documents", force: :cascade do |t|
    t.integer  "sclass_id"
    t.string   "title"
    t.string   "file"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "documents", ["sclass_id"], name: "index_documents_on_sclass_id"

  create_table "groups", force: :cascade do |t|
    t.integer  "sclass_id"
    t.string   "name"
    t.integer  "topic_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "point",      default: 0
  end

  add_index "groups", ["sclass_id"], name: "index_groups_on_sclass_id"
  add_index "groups", ["topic_id"], name: "index_groups_on_topic_id"

  create_table "learnings", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "sclass_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "attendance", default: 0
    t.float    "term_point", default: 0.0
  end

  add_index "learnings", ["sclass_id"], name: "index_learnings_on_sclass_id"
  add_index "learnings", ["student_id"], name: "index_learnings_on_student_id"

  create_table "mini_works", force: :cascade do |t|
    t.string   "name"
    t.float    "ratio"
    t.integer  "sclass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content"
    t.datetime "deadline"
  end

  add_index "mini_works", ["sclass_id"], name: "index_mini_works_on_sclass_id"

  create_table "missed_logs", force: :cascade do |t|
    t.integer  "learning_id"
    t.integer  "schedule_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "missed_logs", ["learning_id"], name: "index_missed_logs_on_learning_id"
  add_index "missed_logs", ["schedule_id"], name: "index_missed_logs_on_schedule_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_type"
    t.string   "content"
    t.string   "link"
    t.boolean  "read",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "point_components", force: :cascade do |t|
    t.integer  "sclass_id"
    t.integer  "mid_term_test", default: 0
    t.integer  "short_test",    default: 0
    t.integer  "apperance",     default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "content"
    t.float    "ratio"
  end

  add_index "point_components", ["sclass_id"], name: "index_point_components_on_sclass_id"

  create_table "points", force: :cascade do |t|
    t.integer  "score_table_id"
    t.integer  "learning_id"
    t.float    "value",          default: 0.0
    t.string   "note"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "points", ["learning_id"], name: "index_points_on_learning_id"
  add_index "points", ["score_table_id"], name: "index_points_on_score_table_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "test_id"
    t.text     "content"
    t.integer  "type"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["test_id"], name: "index_questions_on_test_id"

  create_table "schedules", force: :cascade do |t|
    t.integer  "sclass_id"
    t.date     "date"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "start_time"
    t.string   "ending_time"
    t.integer  "first_lesson"
    t.integer  "last_lesson"
  end

  add_index "schedules", ["sclass_id"], name: "index_schedules_on_sclass_id"

  create_table "sclasses", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sclass_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "room"
  end

  add_index "sclasses", ["subject_id"], name: "index_sclasses_on_subject_id"
  add_index "sclasses", ["teacher_id"], name: "index_sclasses_on_teacher_id"

  create_table "score_tables", force: :cascade do |t|
    t.integer  "sclass_id"
    t.integer  "point_component_id"
    t.string   "title"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "score_tables", ["point_component_id"], name: "index_score_tables_on_point_component_id"
  add_index "score_tables", ["sclass_id"], name: "index_score_tables_on_sclass_id"

  create_table "student_groups", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "student_groups", ["group_id"], name: "index_student_groups_on_group_id"
  add_index "student_groups", ["student_id"], name: "index_student_groups_on_student_id"

  create_table "students", force: :cascade do |t|
    t.string   "std_id"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.date     "last_reminded"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "sbj_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "term_ratio", default: 0.7
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.date     "last_reminded"
  end

  create_table "test_sclasses", force: :cascade do |t|
    t.integer  "test_id"
    t.integer  "sclass_id"
    t.boolean  "opened",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "test_sclasses", ["sclass_id"], name: "index_test_sclasses_on_sclass_id"
  add_index "test_sclasses", ["test_id"], name: "index_test_sclasses_on_test_id"

  create_table "tests", force: :cascade do |t|
    t.integer  "teacher_id"
    t.string   "name"
    t.integer  "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tests", ["teacher_id"], name: "index_tests_on_teacher_id"

  create_table "topics", force: :cascade do |t|
    t.integer  "sclass_id"
    t.text     "content"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topics", ["sclass_id"], name: "index_topics_on_sclass_id"

end
