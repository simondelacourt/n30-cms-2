class CreateStylesheets < ActiveRecord::Migration
  def change
    create_table :stylesheets do |t|
      t.string :title
      t.boolean :selected
      t.text :css
      t.timestamps
    end
  end
end
