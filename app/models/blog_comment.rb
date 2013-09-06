class BlogComment < ActiveRecord::Base
  attr_accessible :blog_post_id, :body, :poster_name
  belongs_to :blog_post
end
