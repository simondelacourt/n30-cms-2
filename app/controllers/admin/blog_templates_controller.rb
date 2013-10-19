class Admin::BlogTemplatesController < ApplicationController 
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @blogtemplates = BlogTemplate.all
    @pagetitle = 'Blog templates'
  end
  def new
    @blogtemplate = BlogTemplate.new
    @pagetitle = 'Nieuwe CSS Stylesheets'
    
  end
  def edit
    @blogtemplate = BlogTemplate.find(params[:id])
    @pagetitle = "Wijzig #{@blogtemplate.title}"
  end
  def create
    @blogtemplate = BlogTemplate.new(params[:blog_template])
    if @blogtemplate.save
      respond_to do |format| 
        format.html {redirect_to edit_admin_blog_template_url(@blogtemplate)}
        format.js { }
      end
    else
      render action: 'new'
    end
  end
  def update
    @blogtemplate = BlogTemplate.find(params[:id])
    if @blogtemplate.update_attributes(params[:blog_template])
      respond_to do |format| 
        format.html {redirect_to edit_admin_blog_template_url(@blogtemplate)}
        format.js { }
      end
    else
      render action: 'edit'
    end
  end
  def destroy
    @blogtemplate = BlogTemplate.find(params[:id])
    @blogtemplate.delete
    redirect_to admin_stylesheets_url
  end

end
