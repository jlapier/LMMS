# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090807161933) do

  create_table "content_pages", :force => true do |t|
    t.integer  "section_id"
    t.string   "title"
    t.integer  "position"
    t.text     "main_body"
    t.text     "secondary_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "layout_image_file_name"
    t.string   "layout_image_content_type"
    t.integer  "layout_image_file_size"
    t.datetime "layout_image_updated_at"
    t.string   "layout_image_alt_text"
  end

  add_index "content_pages", ["section_id"], :name => "index_content_pages_on_section_id"

  create_table "learning_modules", :force => true do |t|
    t.string   "title"
    t.integer  "position"
    t.string   "layout_image_file_name"
    t.string   "layout_image_content_type"
    t.integer  "layout_image_file_size"
    t.datetime "layout_image_updated_at"
    t.string   "layout_image_alt_text"
    t.text     "description"
  end

  create_table "quiz_answers", :force => true do |t|
    t.integer  "quiz_question_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quiz_answers", ["quiz_question_id"], :name => "index_quiz_answers_on_quiz_question_id"

  create_table "quiz_pages", :force => true do |t|
    t.integer  "section_id"
    t.string   "title"
    t.integer  "position"
    t.text     "setup_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "layout_image_file_name"
    t.string   "layout_image_content_type"
    t.integer  "layout_image_file_size"
    t.datetime "layout_image_updated_at"
    t.string   "layout_image_alt_text"
  end

  add_index "quiz_pages", ["section_id"], :name => "index_quiz_pages_on_section_id"

  create_table "quiz_questions", :force => true do |t|
    t.integer  "quiz_page_id"
    t.string   "title"
    t.integer  "position"
    t.text     "body"
    t.text     "explanation"
    t.integer  "correct_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quiz_questions", ["quiz_page_id"], :name => "index_quiz_questions_on_quiz_page_id"

  create_table "sections", :force => true do |t|
    t.integer  "learning_module_id"
    t.integer  "position"
    t.string   "title"
    t.string   "layout_image_file_name"
    t.string   "layout_image_content_type"
    t.integer  "layout_image_file_size"
    t.datetime "layout_image_updated_at"
    t.string   "layout_image_alt_text"
  end

  create_table "site_pages", :force => true do |t|
    t.string   "title"
    t.integer  "position"
    t.text     "body"
    t.string   "layout_image_file_name"
    t.string   "layout_image_content_type"
    t.integer  "layout_image_file_size"
    t.datetime "layout_image_updated_at"
    t.string   "layout_image_alt_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_settings", :force => true do |t|
    t.string   "setting_name"
    t.string   "setting_string_value"
    t.text     "setting_text_value"
    t.integer  "setting_number_value"
    t.boolean  "yamled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_settings", ["setting_name"], :name => "index_site_settings_on_setting_name"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
