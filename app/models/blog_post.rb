class BlogPost < ActiveRecord::Base
  attr_accessible :body, :intro, :title, :user_id, :tag_list, :blog_category_id, :leaderimage, :status
  
  has_many :blog_comments
  
  belongs_to :blog_group
  belongs_to :blog_category
  belongs_to :user
  
  validates :title, presence: true
  validates :user_id, presence: true
  validates :blog_category_id, presence: true
  validates :body, presence: true
  validates :original_id, uniqueness: true
  
  has_attached_file :leaderimage, :styles => {:large => '1000x1000>', :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  
  acts_as_taggable
  
  
  searchable do
    text :title, :body
  end
  
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
  
end
