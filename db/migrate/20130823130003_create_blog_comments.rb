class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.integer :blog_post_id
      t.text :body
      t.text :poster_name

      t.timestamps
    end
  end
end
