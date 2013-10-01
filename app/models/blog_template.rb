class BlogTemplate < ActiveRecord::Base
  attr_accessible :blog_category, :blog_index, :blog_read, :blog_search, :title
end
