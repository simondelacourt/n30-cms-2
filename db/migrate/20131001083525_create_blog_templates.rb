class CreateBlogTemplates < ActiveRecord::Migration
  def change
    create_table :blog_templates do |t|
      t.string :title
      t.text :blog_index, :limit => 4294967295
      t.text :blog_read, :limit => 4294967295
      t.text :blog_search, :limit => 4294967295
      t.text :blog_category, :limit => 4294967295
      t.boolean :mode, :default => false
      t.timestamps
    end
  end
end
