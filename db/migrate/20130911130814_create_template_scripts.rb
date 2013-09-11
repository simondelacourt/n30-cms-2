class CreateTemplateScripts < ActiveRecord::Migration
  def change
    create_table :template_scripts do |t|
      t.integer :template_id
      t.integer :javascript_id
      t.timestamps
    end
  end
end
