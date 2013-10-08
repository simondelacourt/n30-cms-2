class AddPageSetting < ActiveRecord::Migration
  def up
    add_column :pages, :showamountembed, :integer, :default => 0
  end

  def down
    remove_column :pages, :showamountembed
  end
end
