class Gallerypluginhaml < ActiveRecord::Migration
  def up
    add_column :galleryplugins, :haml, :text, :limit => 4294967295
    
  end

  def down
    remove_column :galleryplugins, :haml
    
  end
end
