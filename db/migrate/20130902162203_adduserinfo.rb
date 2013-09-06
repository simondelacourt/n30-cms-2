class Adduserinfo < ActiveRecord::Migration
  def up
    add_column :users, :firstname, :string
    add_column :users, :familyname, :string
    add_column :users, :dateofbirth, :date
  end

  def down
    remove_column :users, :firstname
    remove_column :users, :familyname
    remove_column :users, :dateofbirth
  end
end
