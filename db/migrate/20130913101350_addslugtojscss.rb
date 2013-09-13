class Addslugtojscss < ActiveRecord::Migration
  def up
    add_column :stylesheets, :slug, :string
    add_column :javascripts, :slug, :string
    add_index :stylesheets, :slug, unique: true
    add_index :javascripts, :slug, unique: true
  end

  def down
    remove_column :stylesheets, :slug
    remove_column :javascripts, :slug
    remove_index :javascripts, :slug
    remove_index :javascripts, :slug
    
  end
end
