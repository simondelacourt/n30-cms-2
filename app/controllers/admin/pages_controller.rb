class Admin::PagesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @pages = Page.scoped
  end
  def show
    @page = Page.find(params[:id])
    @ids = [@page.id]
    if @page.sourcefromchildren
      @page.descendants.each do |d|
        @ids.push d.id
      end
      @embeddables = Embeddable.where(page_id: @ids)
    else
      @embeddables = Embeddable.where(page_id: @page.id)
    end
    
  end
  def new
    @page = Page.new
    if params[:parent_id]
      @page.parent_id = params[:parent_id]
    end
  end
  def edit
    @page = Page.find(params[:id])
  end
  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to admin_page_url(@page)
    else
      render action: new
    end
  end
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = 'Pagina gewijzigd'
      redirect_to admin_page_url(@page)
      
    else
      render action: 'edit'
    end
  end
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to admin_pages_url
  end
  
end
