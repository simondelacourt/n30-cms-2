class CreateJavascripts < ActiveRecord::Migration
  def change
    create_table :javascripts do |t|
      t.string :title
      t.text :script
      t.timestamps
    end
  end
end
