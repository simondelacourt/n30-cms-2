class Renamemodel < ActiveRecord::Migration
  def change
    rename_table :galleryplugins, :page_plugins
    
  end
end
