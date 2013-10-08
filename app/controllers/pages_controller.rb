class PagesController < ApplicationController
  def show
    begin
      @page = Page.find(params[:id])
    rescue ActiveRecord::RecordNotFound
       return render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end
    
    
    @ids = [@page.id]
    @pagetitle = @page.title
    
    #embeddables
    if @page.sourcefromchildren
      @page.descendants.each do |d|
        @ids.push d.id
      end
      embeddables = Embeddable.where(page_id: @ids)
    else
      embeddables = Embeddable.where(page_id: @page.id)
    end
    @embeddables = Array.new
    embedarray = Array.new
    if @page.showamountembed > 0
      embeddables.each do |e|
        if embedarray[e.page_id].nil?
          embedarray[e.page_id] = Array.new
        end
        embedarray[e.page_id].push e
      end
      embedarray.each do |e|
        unless e.nil?
          if e.length < @page.showamountembed
            e.each do |i|
              @embeddables.push i
            end
          else
            i = 0
            while i < @page.showamountembed
              @embeddables.push e[i]
              i += 1
            end
          end
        end
      end
    else
      @embeddables = embeddables
    end
    
    # page plugin, loading layout
    
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
