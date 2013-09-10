class CreateThumbStyles < ActiveRecord::Migration
  def change
    create_table :thumb_styles do |t|
      t.string :title
      t.string :sizes
      t.timestamps
    end
  end
end
