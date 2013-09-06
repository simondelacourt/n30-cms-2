class BlogController < ApplicationController
  def index
    @blogposts = BlogPost.order("updated_at desc")
    @bloggroups = BlogGroup.find(:all)
  end
  def show
    @bloggroups = BlogGroup.find(:all)
    
    @blogpost = BlogPost.find(params[:id])
  end
end
