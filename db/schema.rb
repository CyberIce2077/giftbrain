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

ActiveRecord::Schema[8.0].define(version: 2025_09_13_071901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "favorite_products", force: :cascade do |t|
    t.bigint "recipient_id", null: false
    t.string "product_id", default: "", null: false
    t.integer "provider", default: 0, null: false
    t.string "name", default: "", null: false
    t.string "promotion_link", default: "", null: false
    t.string "image", default: "", null: false
    t.string "original_price", default: "", null: false
    t.string "sale_price", default: "", null: false
    t.string "discount", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id", "provider", "product_id"], name: "idx_on_recipient_id_provider_product_id_36e51ecbaf", unique: true
    t.index ["recipient_id"], name: "index_favorite_products_on_recipient_id"
  end

  create_table "ideas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image", default: "", null: false
    t.index ["name"], name: "index_ideas_on_name", unique: true
  end

  create_table "recipient_ideas", force: :cascade do |t|
    t.bigint "recipient_id", null: false
    t.bigint "idea_id", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "affiliate_links", default: {}, null: false
    t.index ["idea_id"], name: "index_recipient_ideas_on_idea_id"
    t.index ["recipient_id", "idea_id"], name: "index_recipient_ideas_on_recipient_id_and_idea_id", unique: true
    t.index ["recipient_id"], name: "index_recipient_ideas_on_recipient_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "status", default: 0, null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recipient_ideas_count", default: 0, null: false
    t.date "event_date"
    t.boolean "repeat_annually", default: true, null: false
    t.string "ship_to_country", default: "US", null: false
    t.index ["creator_id"], name: "index_recipients_on_creator_id"
    t.index ["event_date"], name: "index_recipients_on_event_date"
  end

  create_table "reminders", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.bigint "recipient_id", null: false
    t.integer "kind", default: 0, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_reminders_on_discarded_at"
    t.index ["recipient_id", "kind"], name: "index_reminders_on_recipient_id_and_kind", unique: true
    t.index ["recipient_id"], name: "index_reminders_on_recipient_id"
  end

  create_table "team_members", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id", "user_id"], name: "index_team_members_on_team_id_and_user_id", unique: true
    t.index ["team_id"], name: "index_team_members_on_team_id"
    t.index ["user_id"], name: "index_team_members_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "recipient_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public_join", default: false, null: false
    t.string "public_token", null: false
    t.index ["public_token"], name: "index_teams_on_public_token", unique: true
    t.index ["recipient_id"], name: "index_teams_on_recipient_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.string "provider"
    t.string "uid"
    t.boolean "subscribed", default: true, null: false
    t.string "unsubscribe_token", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unsubscribe_token"], name: "index_users_on_unsubscribe_token", unique: true
  end

  add_foreign_key "favorite_products", "recipients"
  add_foreign_key "recipient_ideas", "ideas"
  add_foreign_key "recipient_ideas", "recipients"
  add_foreign_key "recipients", "users", column: "creator_id"
  add_foreign_key "reminders", "recipients"
  add_foreign_key "team_members", "teams"
  add_foreign_key "team_members", "users"
  add_foreign_key "teams", "recipients"
end
