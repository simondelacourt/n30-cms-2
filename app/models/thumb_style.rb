class ThumbStyle < ActiveRecord::Base
  attr_accessible :title, :sizes
  
  validates :title, presence: true
  validates :sizes, presence: true
  
end
