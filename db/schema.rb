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

ActiveRecord::Schema.define(:version => 20131007151009) do

  create_table "blog_categories", :force => true do |t|
    t.string   "title"
    t.integer  "order"
    t.integer  "blog_group_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "blog_comments", :force => true do |t|
    t.integer  "blog_post_id"
    t.text     "body"
    t.text     "poster_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "blog_groups", :force => true do |t|
    t.string   "title"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "blog_posts", :force => true do |t|
    t.text     "title"
    t.text     "intro"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.text     "tags"
    t.string   "leaderimage_file_name"
    t.string   "leaderimage_content_type"
    t.integer  "leaderimage_file_size"
    t.datetime "leaderimage_updated_at"
    t.integer  "blog_group_id"
    t.integer  "blog_category_id"
    t.string   "status"
    t.string   "original_id"
  end

  create_table "blog_tag_couples", :force => true do |t|
    t.integer  "blog_post_id"
    t.integer  "blog_tag_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "blog_tags", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "blog_templates", :force => true do |t|
    t.string   "title"
    t.text     "blog_index",    :limit => 2147483647
    t.text     "blog_read",     :limit => 2147483647
    t.text     "blog_search",   :limit => 2147483647
    t.text     "blog_category", :limit => 2147483647
    t.boolean  "mode",                                :default => false
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  create_table "embeddables", :force => true do |t|
    t.integer  "page_id"
    t.text     "title"
    t.text     "description"
    t.text     "htmlbody"
    t.text     "link"
    t.string   "linkmode"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "javascripts", :force => true do |t|
    t.string   "title"
    t.text     "script"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "external_link"
    t.string   "slug"
  end

  add_index "javascripts", ["slug"], :name => "index_javascripts_on_slug", :unique => true

  create_table "menus", :force => true do |t|
    t.text     "title"
    t.text     "linkmode"
    t.integer  "linkid"
    t.integer  "ordernum"
    t.string   "ancestry"
    t.string   "index"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "externalink"
  end

  add_index "menus", ["ancestry"], :name => "index_menus_on_ancestry"

  create_table "page_plugins", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.text     "erb",        :limit => 2147483647
    t.text     "css",        :limit => 2147483647
    t.text     "js",         :limit => 2147483647
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "ancestry"
    t.boolean  "sourcefromchildren"
    t.string   "slug"
    t.integer  "page_plugin_id"
    t.integer  "showamountembed",    :default => 0
  end

  add_index "pages", ["ancestry"], :name => "index_pages_on_ancestry"
  add_index "pages", ["slug"], :name => "index_pages_on_slug", :unique => true

  create_table "settings", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "mode"
    t.text     "settings"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stylesheets", :force => true do |t|
    t.string   "title"
    t.boolean  "selected"
    t.text     "css",           :limit => 2147483647
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.text     "external_link"
    t.string   "slug"
  end

  add_index "stylesheets", ["slug"], :name => "index_stylesheets_on_slug", :unique => true

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "template_scripts", :force => true do |t|
    t.integer  "template_id"
    t.integer  "javascript_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "ordernum"
  end

  create_table "template_sheets", :force => true do |t|
    t.integer  "template_id"
    t.integer  "stylesheet_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "ordernum"
  end

  create_table "templates", :force => true do |t|
    t.string   "title"
    t.string   "head_title",       :default => "[title] - [pagetitle]"
    t.boolean  "tdefault"
    t.text     "template"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.text     "head_extra"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "meta_author"
  end

  create_table "thumb_styles", :force => true do |t|
    t.string   "title"
    t.string   "sizes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "firstname"
    t.string   "familyname"
    t.date     "dateofbirth"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
