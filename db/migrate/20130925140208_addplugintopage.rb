class Addplugintopage < ActiveRecord::Migration
  def up
    add_column :pages, :galleryplugin_id, :integer
  end

  def down
    remove_column :pages, :galleryplugin_id
  end
end
