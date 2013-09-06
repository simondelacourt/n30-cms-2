class Adddi < ActiveRecord::Migration
  def up
    add_column :blog_posts, :blog_category_id, :integer
  end

  def down
    remove_column :blog_posts, :blog_category_id
  end
end
