class CreateTemplateSheets < ActiveRecord::Migration
  def change
    create_table :template_sheets do |t|
      t.integer :template_id
      t.integer :stylesheet_id
      t.timestamps
    end
  end
end
