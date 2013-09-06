class CreateBlogGroups < ActiveRecord::Migration
  def change
    create_table :blog_groups do |t|
      t.string :title
      t.integer :order

      t.timestamps
    end
  end
end
