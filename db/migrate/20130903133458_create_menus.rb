class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.text :title
      t.text :linkmode
      t.integer :linkid
      t.integer :order
      t.string :ancestry, :index
      t.timestamps
    end
  end
end
