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

ActiveRecord::Schema.define(version: 20140317190456) do

  create_table "applications", force: true do |t|
    t.date     "dateSent"
    t.text     "coverLetter"
    t.integer  "posting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applications", ["posting_id"], name: "index_applications_on_posting_id"

  create_table "job_applications", force: true do |t|
    t.date     "dateSent"
    t.text     "coverLetter"
    t.integer  "posting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_applications", ["posting_id"], name: "index_job_applications_on_posting_id"

  create_table "job_postings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postings", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.date     "datePosted"
    t.string   "jobLocation"
    t.string   "hiringOrganization"
    t.string   "hiringOrganizationUrl"
    t.string   "contactName"
    t.string   "contactEmail"
    t.string   "applicationUrl"
    t.string   "submissionRequirements"
  end

end
