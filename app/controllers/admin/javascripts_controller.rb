class Admin::JavascriptsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @javascripts = Javascript.all
    @pagetitle = 'Javascripts'
  end
  def new
    @javascript = Javascript.new
    @pagetitle = 'Nieuw script'
  end
  def edit
    @javascript = Javascript.find(params[:id])
    @pagetitle = "Wijzig #{@javascript.title}"
  end
  def create
    @javascript = Javascript.new(params[:javascript])
    if @javascript.save
      @javascript.savetofile
      respond_to do |format| 
        format.html {redirect_to edit_admin_javascript_url(@javascript)}
        format.js { }
      end    
    else
      render action: 'new'
    end
  end
  def update
    @javascript = Javascript.find(params[:id])
    if @javascript.update_attributes(params[:javascript])
      @javascript.savetofile
      respond_to do |format| 
        format.html {redirect_to edit_admin_javascript_url(@javascript)}
        format.js { }
      end    
    else
      render action: 'edit'
    end
  end
  def destroy
    @javascript = Javascript.find(params[:id])
    @javascript.delete
    redirect_to admin_javascripts_url
  end
end
