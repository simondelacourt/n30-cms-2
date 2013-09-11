class Addtemplatefields < ActiveRecord::Migration
  def up
    add_column :templates, :head_title, :string, :default => '[title] - [pagetitle]'
    add_column :templates, :head_extra, :text
    add_column :templates, :meta_keywords, :string
    add_column :templates, :meta_description, :string
    add_column :templates, :meta_author, :string
    add_column :javascripts, :external_link, :text
    add_column :stylesheets, :external_link, :text
  end

  def down
    remove_column :templates, :head_title
    remove_column :templates, :head_extra
    remove_column :templates, :meta_keywords
    remove_column :templates, :meta_description
    remove_column :templates, :meta_author
    remove_column :javascripts, :external_link
    remove_column :stylesheets, :external_link
  end
end
