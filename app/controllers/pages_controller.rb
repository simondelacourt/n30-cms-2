class PagesController < ApplicationController
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
    
    if !@page.page_plugin.nil?
      unless @page.page_plugin.js.blank?
        @sideloaderJS.push(side_pageplugin_url(:id => @page.page_plugin.id, :format => 'js', :page => @page.id))
      end
      unless @page.page_plugin.css.blank?
        @sideloaderCSS.push(side_pageplugin_url(:id => @page.page_plugin.id, :format => 'css', :page => @page.id))
      end
    end
    begin
      render :inline => @page.page_plugin.erb, :layout => true, :locals => {:page => @page, :embeddables => @embeddables}
    rescue ActionView::Template::Error => e
      render :inline => "Template error + #{e}", :layout => true
      
    end
    
  end
end
