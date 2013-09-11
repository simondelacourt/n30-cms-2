class Changetolongtexttemplate < ActiveRecord::Migration
  def change
    change_column :stylesheets, :css, :text, :limit => 4294967295
    
  end
end
