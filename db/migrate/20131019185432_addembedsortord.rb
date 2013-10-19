class Addembedsortord < ActiveRecord::Migration
  def change
    add_column :embeddables, :sortorder, :integer, :default => 0
  end
end
