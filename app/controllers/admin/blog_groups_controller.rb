class Admin::BlogGroupsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  def index
    @groups = BlogGroup.find(:all)
    @group = BlogGroup.new
    @pagetitle = 'Blog categorien'
    
  end
  def new
    @group = BlogGroup.new
  end
  def show
    @group = BlogGroup.find(params[:id])
  end
  def create
    @group = BlogGroup.new(params[:blog_group])
    if @group.save 
      redirect_to admin_blog_groups_path
    else
      render :new
    end
  end
  def destroy
    @group = BlogGroup.find(params[:id])
    @group.delete
    redirect_to admin_blog_groups_path
  end
  def edit
    @group = BlogGroup.find(params[:id])
  end
  def update
    @group = BlogGroup.find(params[:id])
    if @group.update_attributes(params[:blog_group])
      redirect_to admin_blog_groups_path
    else
      render :action => 'edit'
    end
  end
end
