class Admin::BlogCategoriesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  def new
    @pagetitle = 'Nieuwe categorie'
    @category = BlogCategory.new
  end
  def create
    @group = BlogGroup.find(params[:blog_group_id])
    @category = @group.blog_categories.new(params[:blog_category])
    if @category.save
      redirect_to admin_blog_groups_url
    else
      render :action => 'new'
    end
  end
  def destroy 
    @category = BlogCategory.find(params[:id])
    @category.delete
    redirect_to admin_blog_groups_url
  end
  def edit
    @category = BlogCategory.find(params[:id])
    @pagetitle = 'Wijzig ' + @category.title
  end
  def update
    @category = BlogCategory.find(params[:id])
    if @category.update_attributes(params[:blog_category])
      redirect_to admin_blog_groups_url
    else
      render :action => 'edit'
    end
  end
end
