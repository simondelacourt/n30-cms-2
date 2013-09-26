class Embeddable < ActiveRecord::Base
  attr_accessible :title, :body, :htmlbody, :linkmode, :description, :image
  belongs_to :page
  validates :title, presence: true
  
  has_attached_file :image, :styles => Proc.new { |clip| clip.instance.attachment_sizes }
  

  def attachment_sizes
    sizes = { :thumb => "100x100" }
    tm = ThumbStyle.find(:all)
    tm.each do |size|
      sizes[:"#{size.title}"] = [size.sizes]
    end
    sizes
  end
  def image_tag (test)
    return test
    
  end
  

  
end
