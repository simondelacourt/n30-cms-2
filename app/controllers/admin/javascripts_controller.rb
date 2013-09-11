class Admin::JavascriptsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @javascripts = Javascript.find(:all)
  end
  def new
    @javascript = Javascript.new
  end
  def edit
    @javascript = Javascript.find(params[:id])
  end
  def create
    @javascript = Javascript.new(params[:javascript])
    if @javascript.save
      redirect_to admin_javascripts_url
    else
      render action: 'new'
    end
  end
  def update
    @javascript = Javascript.find(params[:id])
    if @javascript.update_attributes(params[:javascript])
      redirect_to edit_admin_javascript_url(@javascript)
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
