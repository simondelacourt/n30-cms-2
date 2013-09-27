class CreateGalleryplugins < ActiveRecord::Migration
  def change
    create_table :galleryplugins do |t|
      t.string :title
      t.timestamps
    end
  end
end
