class Addembedmode < ActiveRecord::Migration
  def up
    add_column :pages, :sourcefromchildren, :boolean
  end

  def down
  end
end
