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

ActiveRecord::Schema.define(version: 20140524183512) do

  create_table "interviews", force: true do |t|
    t.datetime "date"
    t.integer  "posting_id"
    t.string   "interviewer"
    t.text     "notes"
    t.string   "contact_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interviews", ["posting_id"], name: "index_interviews_on_posting_id"

  create_table "job_applications", force: true do |t|
    t.date     "date_sent"
    t.text     "cover_letter"
    t.integer  "posting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_applications", ["posting_id"], name: "index_job_applications_on_posting_id"

  create_table "postings", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.date     "date_posted"
    t.string   "job_location"
    t.string   "hiring_organization"
    t.string   "hiring_organization_url"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "application_url"
    t.date     "deadline"
    t.text     "application_instructions"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token"
  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token"

end
