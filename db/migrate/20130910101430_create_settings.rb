class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :title
      t.text :description
      t.string :mode
      t.text :settings
      t.timestamps
    end
  end
end
