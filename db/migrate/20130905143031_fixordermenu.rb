class Fixordermenu < ActiveRecord::Migration
  def up
    rename_column :menus, :order, :ordernum
  end

  def down
    rename_column :menus, :ordernum, :order
    
  end
end
