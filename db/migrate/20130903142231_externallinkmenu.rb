class Externallinkmenu < ActiveRecord::Migration
  def up
    add_column :menus, :externalink, :text
  end

  def down
    remove_column :menus, :externalink
  end
end
