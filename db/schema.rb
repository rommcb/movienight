# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_17_093237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: :cascade do |t|
    t.string "fullname", null: false
  end

  create_table "castings", force: :cascade do |t|
    t.bigint "actor_id", null: false
    t.bigint "movie_id", null: false
    t.index ["actor_id"], name: "index_castings_on_actor_id"
    t.index ["movie_id"], name: "index_castings_on_movie_id"
  end

  create_table "directors", force: :cascade do |t|
    t.string "fullname", null: false
  end

  create_table "event_movies", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "event_id", null: false
    t.integer "score", default: 0
    t.index ["event_id"], name: "index_event_movies_on_event_id"
    t.index ["movie_id"], name: "index_event_movies_on_movie_id"
  end

  create_table "event_subscriptions", force: :cascade do |t|
    t.boolean "owner", null: false
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_event_subscriptions_on_event_id"
    t.index ["user_id"], name: "index_event_subscriptions_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "date_end", null: false
    t.datetime "date_start", null: false
    t.text "description"
    t.string "code"
    t.string "where"
    t.boolean "closed", default: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "genres_attributions", force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "movie_id", null: false
    t.index ["genre_id"], name: "index_genres_attributions_on_genre_id"
    t.index ["movie_id"], name: "index_genres_attributions_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.bigint "director_id"
    t.string "title", null: false
    t.text "synopsis", null: false
    t.integer "duration", null: false
    t.string "cover"
    t.index ["director_id"], name: "index_movies_on_director_id"
  end

  create_table "preferences_actors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "actor_id", null: false
    t.index ["actor_id"], name: "index_preferences_actors_on_actor_id"
    t.index ["user_id"], name: "index_preferences_actors_on_user_id"
  end

  create_table "preferences_directors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "director_id", null: false
    t.index ["director_id"], name: "index_preferences_directors_on_director_id"
    t.index ["user_id"], name: "index_preferences_directors_on_user_id"
  end

  create_table "preferences_genres", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "genre_id", null: false
    t.index ["genre_id"], name: "index_preferences_genres_on_genre_id"
    t.index ["user_id"], name: "index_preferences_genres_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_movie_id", null: false
    t.index ["event_movie_id"], name: "index_reviews_on_event_movie_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", default: ""
    t.integer "max_duration_pref", default: 600
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
