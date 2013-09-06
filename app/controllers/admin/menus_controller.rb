class Admin::MenusController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin'
  
  def index
    @menus = Menu.scoped
  end
  def show
    @menu = Menu.find(params[:id])
  end
  def new
    @menu = Menu.new
    if params[:parent_id]
      @menu.parent_id = params[:parent_id]
    end
  end
  def edit
    @menu = Menu.find(params[:id])
  end
  
  def create
    @menu = Menu.new(params[:menu])
    @menu.ordernum = Menu.count(:all) + 1
    if @menu.save
      redirect_to admin_menus_url
    else
      render :action => 'new'
    end
  end
  def destroy
    @menu = Menu.find(params[:id])
    @menu.delete
    redirect_to admin_menus_url
  end
  def saveorder
    respond_to do |format|
      format.html
      format.json {
        data =  params[:order].split(".")
        counter = 0
        data.each do |d|
          counter += 1
          currentid = d[4..d.length+1]
          menuitem = Menu.find(currentid)
          menuitem.update_attribute(:ordernum, counter)
        end
        
        render :json => {:status => 'ok'}
      }
    end
    
  end
end
