class Removepid < ActiveRecord::Migration
  def up
    remove_column :pages, :parent_id
  end

  def down
  end
end
