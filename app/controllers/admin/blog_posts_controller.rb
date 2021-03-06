class Admin::BlogPostsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag' # <- New
  
  def index
    @blogposts = BlogPost.paginate(:page => params[:page]).order("created_at DESC")
    @pagetitle = 'Blogberichten'
  end
  def show
    @blogpost = BlogPost.find(params[:id])
    @pagetitle = @blogpost.title
  end
  def new 
    @blogpost = BlogPost.new
    @blogpost.status = 'unpublished'
    @bloggroup = BlogGroup.all
    @pagetitle = 'Nieuwe blog groep'
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blogpost }
    end
  end
  def edit
    @blogpost = BlogPost.find(params[:id])
    @bloggroup = BlogGroup.all
    @pagetitle = 'Wijzig ' + @blogpost.title
  end
  def create
    @blogpost = BlogPost.new(params[:blog_post])
    @lastblogpost = BlogPost.last
    @blogpost.original_id = String(@lastblogpost.id + 1).crypt("$6$somesalt")
    @bloggroup = BlogGroup.all
    
    @blogpost.user = current_user
    if @blogpost.save
      redirect_to admin_blog_post_path(@blogpost)
    else
      render action: "new"
    end
  end
  def update
    @blogpost = BlogPost.find(params[:id])
    
    if @blogpost.update_attributes(params[:blog_post])
      redirect_to admin_blog_post_path(@blogpost)
    else
      render action: "edit"
    end
  end
  def destroy 
    @blogpost = BlogPost.find(params[:id])
    @blogpost.delete
    
    redirect_to admin_blog_posts_url
  end
end
