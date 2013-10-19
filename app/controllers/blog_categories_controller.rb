class BlogCategoriesController < ApplicationController
  def show
    @category = BlogCategory.find(params[:id])
    @blogposts = @category.blog_posts.order("created_at desc")
    @bloggroups = BlogGroup.all
    
  end
end
