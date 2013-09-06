class CreateBlogCategories < ActiveRecord::Migration
  def change
    create_table :blog_categories do |t|
      t.string :title
      t.integer :order
      t.integer :blog_group_id

      t.timestamps
    end
  end
end
