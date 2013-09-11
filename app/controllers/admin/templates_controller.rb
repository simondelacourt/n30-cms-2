class Admin::TemplatesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @templates = Template.find(:all)
    @pagetitle = 'Templates'
  end
  def new
    @template = Template.new
    @pagetitle = 'Nieuwe template'
  end
  def edit
    @template = Template.find(params[:id])
    @pagetitle = "Wijzig #{@template.title}"
  end
  def create
    @template = Template.new(params[:template])
    if @template.save
      redirect_to admin_templates_url
    else
      render action: 'new'
    end
  end
  def update
    @template = Template.find(params[:id])
    @template.attributes = {'stylesheet_ids' => []}.merge(params[:template] || {})
    
    if @template.update_attributes(params[:template])
      redirect_to edit_admin_template_url(@template)
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
