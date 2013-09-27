class Uppdatehamltoerb < ActiveRecord::Migration
  def change
    rename_column :galleryplugins, :haml, :erb
  end

end
