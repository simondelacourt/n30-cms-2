class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :title
      t.boolean :default
      t.text :template
      t.timestamps
    end
  end
end
