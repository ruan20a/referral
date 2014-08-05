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

ActiveRecord::Schema.define(version: 20140804113650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "accesses", force: true do |t|
    t.integer "company_id"
    t.integer "user_id"
    t.integer "level",      default: 1
  end

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "job_id"
    t.integer  "profile_id"
    t.string   "company_name"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.string   "industry"
    t.integer  "company_id"
  end

  add_index "admins", ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true, using: :btree
  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["invitation_token"], name: "index_admins_on_invitation_token", unique: true, using: :btree
  add_index "admins", ["invitations_count"], name: "index_admins_on_invitations_count", using: :btree
  add_index "admins", ["invited_by_id"], name: "index_admins_on_invited_by_id", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "admins_jobs", id: false, force: true do |t|
    t.integer "admin_id", null: false
    t.integer "job_id",   null: false
  end

  add_index "admins_jobs", ["admin_id", "job_id"], name: "index_admins_jobs_on_admin_id_and_job_id", using: :btree
  add_index "admins_jobs", ["job_id", "admin_id"], name: "index_admins_jobs_on_job_id_and_admin_id", using: :btree

  create_table "admins_referrals", id: false, force: true do |t|
    t.integer "admin_id",    null: false
    t.integer "referral_id", null: false
  end

  add_index "admins_referrals", ["admin_id", "referral_id"], name: "index_admins_referrals_on_admin_id_and_referral_id", using: :btree
  add_index "admins_referrals", ["referral_id", "admin_id"], name: "index_admins_referrals_on_referral_id_and_admin_id", using: :btree

  create_table "authorizations", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_page"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "access_token"
    t.text     "address_line_1"
    t.text     "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "postal_code"
    t.integer  "level",          default: 1
    t.text     "description"
    t.string   "industry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", force: true do |t|
    t.integer  "referral_id"
    t.boolean  "admin_notification",    default: false
    t.boolean  "first_admin_reminder",  default: false
    t.boolean  "first_user_reminder",   default: false
    t.boolean  "second_admin_reminder", default: false
    t.boolean  "second_user_reminder",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.integer  "user_id"
    t.string   "invited_name"
    t.string   "invited_email"
    t.boolean  "is_successful", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "recruiter_id"
    t.string   "speciality_1"
    t.float    "referral_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
    t.integer  "referral_id"
    t.string   "city"
    t.string   "state"
    t.string   "job_name"
    t.string   "logo_url"
    t.string   "image"
    t.string   "industry_1"
    t.boolean  "is_active",    default: true
    t.float    "min_salary",   default: 0.0
    t.integer  "company_id"
    t.boolean  "is_public",    default: true
  end

  create_table "profiles", force: true do |t|
    t.integer  "admin_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referrals", force: true do |t|
    t.string   "name"
    t.string   "referral_name"
    t.string   "relationship"
    t.string   "referral_email"
    t.string   "additional_details"
    t.string   "linked_profile_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",               default: "Pending"
    t.integer  "job_id"
    t.integer  "user_id"
    t.integer  "admin_id"
    t.string   "github_profile_url"
    t.boolean  "relevant"
    t.string   "relevance"
    t.string   "ref_type"
    t.string   "referee_email"
    t.text     "personal_note"
    t.string   "referee_name"
    t.boolean  "is_interested"
    t.boolean  "is_active",            default: true
    t.datetime "last_status_update",   default: '2014-06-11 00:32:29'
    t.datetime "last_interest_update", default: '2014-06-11 00:32:29'
    t.string   "referral_token"
  end

  create_table "user_profiles", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "headline"
    t.string   "industry"
    t.string   "image"
    t.string   "public_profile_url"
    t.string   "location"
    t.string   "skills",             default: [], array: true
    t.json     "positions"
    t.json     "educations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "industry_1"
    t.string   "industry_2"
    t.string   "speciality_1"
    t.string   "speciality_2"
    t.integer  "profile_id"
    t.integer  "referral_id"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "tagline"
    t.string   "linked_in"
    t.string   "inviter_email"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "views", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "views", ["email"], name: "index_views_on_email", unique: true, using: :btree
  add_index "views", ["reset_password_token"], name: "index_views_on_reset_password_token", unique: true, using: :btree

  create_table "whitelists", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",      default: 1
  end

end
