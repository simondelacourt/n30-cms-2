class Addtags < ActiveRecord::Migration
  def up
    add_column :blog_posts, :tags, :text
  end

  def down
  end
end
