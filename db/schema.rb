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

ActiveRecord::Schema.define(version: 2021_03_20_131702) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.integer "trackable_id"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable"
  end

  create_table "challenge_users", force: :cascade do |t|
    t.integer "challenge_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["challenge_id"], name: "index_challenge_users_on_challenge_id"
    t.index ["user_id"], name: "index_challenge_users_on_user_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.text "verse_1"
    t.text "verse_2"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "micropost_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["micropost_id"], name: "index_comments_on_micropost_id"
    t.index ["user_id", "micropost_id", "created_at"], name: "index_comments_on_user_id_and_micropost_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "daily_challenges", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "postStatus", default: false
    t.datetime "thirtyDates"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "thirtyDates", "created_at"], name: "index_daily_challenges_on_user_id_and_thirtyDates_and_created_at"
    t.index ["user_id"], name: "index_daily_challenges_on_user_id"
  end

  create_table "haiku_comments", force: :cascade do |t|
    t.text "verse_1"
    t.text "verse_2"
    t.text "verse_3"
    t.integer "user_id", null: false
    t.integer "haiku_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["haiku_id"], name: "index_haiku_comments_on_haiku_id"
    t.index ["user_id"], name: "index_haiku_comments_on_user_id"
  end

  create_table "haiku_reactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "haiku_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["haiku_id"], name: "index_haiku_reactions_on_haiku_id"
    t.index ["user_id", "haiku_id"], name: "index_haiku_reactions_on_user_id_and_haiku_id", unique: true
    t.index ["user_id"], name: "index_haiku_reactions_on_user_id"
  end

  create_table "haikus", force: :cascade do |t|
    t.text "verse_1"
    t.text "verse_2"
    t.text "verse_3"
    t.boolean "public", default: true
    t.string "bgcolor", default: ""
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tag"
    t.index ["user_id", "created_at"], name: "index_haikus_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_haikus_on_user_id"
  end

  create_table "microposts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "message"
    t.text "notification_type"
    t.integer "user_id", null: false
    t.integer "haiku_reaction_id"
    t.integer "haiku_comment_id"
    t.integer "challenge_user_id"
    t.integer "relationship_id"
    t.boolean "is_seen"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["challenge_user_id"], name: "index_notifications_on_challenge_user_id"
    t.index ["haiku_comment_id"], name: "index_notifications_on_haiku_comment_id"
    t.index ["haiku_reaction_id"], name: "index_notifications_on_haiku_reaction_id"
    t.index ["relationship_id"], name: "index_notifications_on_relationship_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "micropost_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["micropost_id"], name: "index_reactions_on_micropost_id"
    t.index ["user_id", "micropost_id"], name: "index_reactions_on_user_id_and_micropost_id", unique: true
    t.index ["user_id"], name: "index_reactions_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean "challenge_mode", default: false
    t.datetime "challenge_start_date"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "challenge_users", "challenges"
  add_foreign_key "challenge_users", "users"
  add_foreign_key "challenges", "users"
  add_foreign_key "comments", "microposts"
  add_foreign_key "comments", "users"
  add_foreign_key "daily_challenges", "users"
  add_foreign_key "haiku_comments", "haikus"
  add_foreign_key "haiku_comments", "users"
  add_foreign_key "haiku_reactions", "haikus"
  add_foreign_key "haiku_reactions", "users"
  add_foreign_key "haikus", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "notifications", "challenge_users"
  add_foreign_key "notifications", "haiku_comments"
  add_foreign_key "notifications", "haiku_reactions"
  add_foreign_key "notifications", "relationships"
  add_foreign_key "notifications", "users"
  add_foreign_key "reactions", "microposts"
  add_foreign_key "reactions", "users"
end
