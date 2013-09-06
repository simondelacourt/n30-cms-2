class Admin::PagesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @pages = Page.scoped
  end
  def show
    @page = Page.find(params[:id])
    @ids = [params[:id].to_i]
    if @page.sourcefromchildren
      @page.descendants.each do |d|
        @ids.push d.id
      end
      @embeddables = Embeddable.where(page_id: @ids)
    else
      @embeddables = Embeddable.where(page_id: params[:id])
    end
  end
  def destroy
    
  end
  def new
    @page = Page.new
    if params[:parent_id]
      @page.parent_id = params[:parent_id]
    end
  end
  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to admin_page_path(@page)
    else
      render action: new
    end
  end
  def update
    
  end
end
