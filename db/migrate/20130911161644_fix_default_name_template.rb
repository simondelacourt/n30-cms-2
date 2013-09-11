class FixDefaultNameTemplate < ActiveRecord::Migration
  def change
    rename_column :templates, :default, :tdefault
  end

end
