class Admin::PagesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @pages = Page.all
    @pagetitle = 'Pagina\'s'
  end
  def show
    @page = Page.friendly.find(params[:id])
    @ids = [@page.id]
    if @page.sourcefromchildren
      @page.descendants.each do |d|
        @ids.push d.id
      end
      @embeddables = Embeddable.where(page_id: @ids).order('sortorder ASC')
    else
      @embeddables = Embeddable.where(page_id: @page.id).order('sortorder ASC')
    end
    @pagetitle = @page.title
  end
  def new
    @page = Page.new
    @pagetitle = 'Nieuwe pagina'
    if params[:parent_id]
      @page.parent_id = params[:parent_id]
    end
  end
  def edit
    @page = Page.friendly.find(params[:id])
    @pagetitle = "Wijzig #{@page.title}"
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
    @page = Page.friendly.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = 'Pagina gewijzigd'
      redirect_to admin_page_url(@page)
      
    else
      render action: 'edit'
    end
  end
  def destroy
    @page = Page.friendly.find(params[:id])
    @page.destroy
    redirect_to admin_pages_url
  end
  def saveorder
    respond_to do |format|
      format.json {
        data =  params[:order].split(".")
        counter = 0
        data.each do |d|
          counter += 1
          currentid = d[3..d.length+1]
          embed = Embeddable.find(currentid)
          embed.update_attribute(:sortorder, counter)
        end
        
        render :json => {:status => 'ok'}
        
      }
    end
  end
  
end
