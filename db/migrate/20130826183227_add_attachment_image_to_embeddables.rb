class AddAttachmentImageToEmbeddables < ActiveRecord::Migration
  def self.up
    change_table :embeddables do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :embeddables, :image
  end
end
