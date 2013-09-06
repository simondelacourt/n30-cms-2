class Leaderimage < ActiveRecord::Migration
  def up
    
    change_table :blog_posts do |t|
      t.attachment :leaderimage
    end
    
  end

  def down
    drop_attached_file :blog_posts, :leaderimage
    
  end
end
