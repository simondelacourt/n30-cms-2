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
      if params[:template][:tdefault]
        @template.setdefaulttemplate
      end
      
      redirect_to admin_templates_url
    else
      render action: 'new'
    end
  end
  def update
    @template = Template.find(params[:id])
    @template.attributes = {'stylesheet_ids' => []}.merge(params[:template] || {})
    if params[:template][:tdefault]
      @template.setdefaulttemplate
    end
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
  
  def savecssorder
    respond_to do |format|
      format.html
      format.json {
        data =  params[:order].split(".")
        counter = 0
        data.each do |d|
          counter += 1
          currentid = d[4..d.length+1]
          css = TemplateSheet.find(currentid)
          css.ordernum = counter
          css.save
        end
        
        render :json => {:status => 'ok'}
      }
    end
  end
  def savejsorder
    respond_to do |format|
      format.html
      format.json {
        expires_in(1)
        
        data =  params[:order].split(".")
        counter = 0
        data.each do |d|
          counter += 1
          currentid = d[4..d.length+1]
          js = TemplateScript.find(currentid)
          js.ordernum = counter
          if !js.save
            raise js.errors.inspect
          end
        end
        
        render :json => {:status => 'ok'}
      }
    end
  end



end
