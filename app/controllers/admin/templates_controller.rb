class Admin::TemplatesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @templates = Template.find(:all)
  end
  def new
    @template = Template.new
  end
  def edit
    @template = Template.find(params[:id])
  end
  def create
    @template = Template.new(params[:stylesheet])
    if @template.save
      redirect_to admin_templates_url
    else
      render action: 'new'
    end
  end
  def update
    @template = Template.find(params[:id])
    if @template.update_attributes(params[:stylesheet])
      redirect_to admin_stylesheets_url
    else
      render action: 'edit'
    end
  end
  def destroy
    @template = Template.find(params[:id])
    @template.delete
    redirect_to admin_templates_url
  end

end
