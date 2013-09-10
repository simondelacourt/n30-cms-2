class Embeddable < ActiveRecord::Base
  attr_accessible :title, :body, :htmlbody, :linkmode, :description, :image
  belongs_to :page
  
  has_attached_file :image, :styles => {:large => '1000x1000>', :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  
  validates :title, presence: true
end
