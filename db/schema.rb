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

ActiveRecord::Schema.define(version: 20141114010651) do

  create_table "interviews", force: true do |t|
    t.datetime "datetime"
    t.integer  "posting_id"
    t.string   "interviewer"
    t.text     "notes"
    t.string   "contact_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interviews", ["posting_id"], name: "index_interviews_on_posting_id"

  create_table "job_applications", force: true do |t|
    t.datetime "date_sent"
    t.text     "cover_letter"
    t.integer  "posting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "followup"
  end

  add_index "job_applications", ["posting_id"], name: "index_job_applications_on_posting_id"

  create_table "offers", force: true do |t|
    t.string   "salary"
    t.text     "details"
    t.integer  "posting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offers", ["posting_id"], name: "index_offers_on_posting_id"

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
    t.boolean  "archived",                 default: false
    t.integer  "user_id"
    t.string   "contact_number"
  end

  add_index "postings", ["archived"], name: "index_postings_on_archived"

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
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "photo"
    t.integer  "application_goal",       default: 7
    t.integer  "followup_offset",        default: 14
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token"
  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token"

end
