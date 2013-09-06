class Addindextomenus < ActiveRecord::Migration
  def up
    add_index :menus, :ancestry

    
  end

  def down
      remove_index :menus, :ancestry
  end
end
