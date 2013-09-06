class CreateEmbeddables < ActiveRecord::Migration
  def change
    create_table :embeddables do |t|
      t.integer :page_id
      t.text :title
      t.text :description
      t.text :htmlbody
      t.text :link
      t.string :linkmode
      
      t.timestamps
    end
  end
end
