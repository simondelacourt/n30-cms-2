class Admin::EmbeddablesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  def new
    @embeddable = Embeddable.new
    @embeddable.page = Page.find(params[:page_id])
    @mode = params[:mode]
  end
  def create
    
    @embeddable = Embeddable.new(params[:embeddable])
    @embeddable.page_id = params[:page_id]
    if @embeddable.save
      redirect_to admin_page_url(params[:page_id])
    else
      render :new
    end
  end
end
