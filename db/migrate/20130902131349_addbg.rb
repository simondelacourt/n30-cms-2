class Addbg < ActiveRecord::Migration
  def up
    add_column :blog_posts, :blog_group_id, :integer
  end

  def down
    remove_column :blog_posts, :blog_group_id
    
  end
end
