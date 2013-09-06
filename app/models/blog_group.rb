class BlogGroup < ActiveRecord::Base
  attr_accessible :order, :title
  
  validates :title, presence: true
  has_many :blog_categories, dependent: :destroy
end
