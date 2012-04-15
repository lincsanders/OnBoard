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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120415202514) do

  create_table "_posts_old_20120415", :force => true do |t|
    t.string   "file_name"
    t.string   "unique_id"
    t.string   "mime_type"
    t.integer  "rating"
    t.integer  "size"
    t.integer  "uploaded_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "file_name"
    t.string   "unique_id"
    t.string   "mime_type"
    t.integer  "rating"
    t.integer  "size"
    t.integer  "uploaded_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uploaded_by_name"
    t.string   "image_title"
  end

end
