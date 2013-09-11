class Addordertotemplateincs < ActiveRecord::Migration
  def up
    add_column :template_scripts, :ordernum, :integer
    add_column :template_sheets, :ordernum, :integer
  end

  def down
    remove_column :template_scripts, :ordernum
    remove_column :template_sheets, :ordernum
  end
end
