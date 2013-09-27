class Admin::PagePluginsController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin'
  
  def index
    @pageplugins = PagePlugin.find(:all)
  end
  def new
    @pageplugin = PagePlugin.new
  end
  def edit
    @pageplugin = PagePlugin.find(params[:id])
  end
  def create
    @pageplugin = PagePlugin.new(params[:page_plugin])
    if @pageplugin.save
      respond_to do |format| 
        format.html {redirect_to edit_admin_page_plugin_url(@pageplugin)}
        format.js { }
      end
    else
      render action: 'new'
    end
  end
  def update
    @pageplugin = PagePlugin.find(params[:id])
    if @pageplugin.update_attributes(params[:page_plugin])
      respond_to do |format| 
        format.html {redirect_to edit_admin_page_plugin_url(@pageplugin)}
        format.js { }
      end
    else
      render action: 'edit'
    end
  end
  def destroy
    @pageplugin = PagePlugin.find(params[:id])
    @pageplugin.destroy
    redirect_to admin_page_plugins_url
  end
  
end
