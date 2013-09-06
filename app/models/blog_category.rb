class BlogCategory < ActiveRecord::Base
  attr_accessible :blog_group_id, :order, :title
  belongs_to :blog_group
  has_many :blog_posts
  
  validates :title, presence: true
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
end
