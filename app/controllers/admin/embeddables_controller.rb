class Admin::EmbeddablesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  def new
    @embeddable = Embeddable.new
    @embeddable.page = Page.find(params[:page_id])
    @mode = params[:mode]
  end
  def create
    if params[:embeddable][:linkmode] == 'link'
      @embeddable = Embeddable.new(params[:embeddable])
      @embeddable.page_id = params[:page_id]
      if @embeddable.save
        redirect_to admin_page_url(params[:page_id])
      else
        render :new
      end
    else
      @embeddable = Embeddable.new(params[:embeddable])
      @embeddable.page_id = params[:page_id]
      respond_to do |format|
        if @embeddable.save
          format.js
        else
          @error = true
          format.js
        end
      end
    end
  end
  def edit
    @embeddable = Embeddable.find(params[:id])
  end
  def update
    @embeddable = Embeddable.find(params[:id])
    if @embeddable.update_attributes(params[:embeddable])
      
      respond_to do |format|
        format.html { redirect_to admin_page_url(params[:page_id]) }
        format.js {}
      end
      
    else
      respond_to do |format|
        format.html { render :edit }
        format.js {}
      end
    end
        
  end
end
