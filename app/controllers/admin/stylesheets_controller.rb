class Admin::StylesheetsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @stylesheets = Stylesheet.find(:all)
    @pagetitle = 'CSS Stylesheets'
  end
  def new
    @stylesheet = Stylesheet.new
    @pagetitle = 'Nieuwe CSS Stylesheets'
    
  end
  def edit
    @stylesheet = Stylesheet.find(params[:id])
    @pagetitle = "Wijzig #{@stylesheet.title}"
  end
  def create
    @stylesheet = Stylesheet.new(params[:stylesheet])
    if @stylesheet.save
      @stylesheet.savetofile
      respond_to do |format| 
        format.html {redirect_to edit_admin_stylesheet_url(@stylesheet)}
        format.js { }
      end
    else
      render action: 'new'
    end
  end
  def update
    @stylesheet = Stylesheet.find(params[:id])
    if @stylesheet.update_attributes(params[:stylesheet])
      @stylesheet.savetofile
      
      respond_to do |format| 
        format.html {redirect_to edit_admin_stylesheet_url(@stylesheet)}
        format.js { }
      end
    else
      render action: 'edit'
    end
  end
  def destroy
    @stylesheet = Stylesheet.find(params[:id])
    @stylesheet.delete
    redirect_to admin_stylesheets_url
  end
end
