class Changeplugincolumn < ActiveRecord::Migration
  def change
    rename_column :pages, :galleryplugin_id, :page_plugin_id
  end

end
