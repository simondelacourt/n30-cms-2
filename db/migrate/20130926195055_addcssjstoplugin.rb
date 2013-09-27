class Addcssjstoplugin < ActiveRecord::Migration
  def up
    add_column :galleryplugins, :css, :text, :limit => 4294967295
    add_column :galleryplugins, :js, :text, :limit => 4294967295
    
  end

  def down
    remove_column :galleryplugins, :css
    remove_column :galleryplugins, :js
  end
end
