class BlogUpdates < ActiveRecord::Migration
  def up
    add_column :blog_posts, :status, :string
    add_column :blog_posts, :original_id, :string
  end

  def down
    remove_column :blog_posts, :status
    remove_column :blog_posts, :original_id
  end
end
