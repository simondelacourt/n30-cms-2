class Admin::ThumbnailsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @thumbnails = ThumbStyle.find(:all)
  end
  def new
    @thumbnail = ThumbStyle.new
  end
  def edit
    @thumbnail = ThumbStyle.find(params[:id])
  end
  def create
    @thumbnail = ThumbStyle.new(params[:thumb_style])
    if @thumbnail.save
      redirect_to admin_thumb_styles_url
    else
      render action: 'new'
    end
  end
  def update
    @thumbnail = ThumbStyle.find(params[:id])
    if @thumbnail.update_attributes(params[:thumb_style])
      redirect_to admin_thumb_styles_url
    else
      render action: 'edit'
    end
  end
  def destroy
    @thumbnail = ThumbStyle.find(params[:id])
    @thumbnail.delete
    redirect_to admin_thumb_styles_url
  end
end
