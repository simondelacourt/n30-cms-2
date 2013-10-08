class HomeController < ApplicationController
  def index
    if @appsettings['home'].nil?
      home = 'blog'
    else
      if @appsettings['home'] == 'blog'
        home == 'blog'
      else
        page = @appsettings['home'][5..-1]
        home = 'page'
      end
    end
    if home == 'blog'
      @blogtemplate = BlogTemplate.find_by_mode(true)
      if @blogtemplate.nil?
        # no template? take first
        @blogtemplate = BlogTemplate.first
      end
      @blogposts = BlogPost.paginate(:page => params[:page], :per_page => 10).order("created_at desc")
      @bloggroups = BlogGroup.find(:all)
      begin
        render :inline => @blogtemplate.blog_index, :layout => true, :locals => {:blogposts => @blogposts, :bloggroups => @bloggroups}
      rescue ActionView::Template::Error => e
        render :inline => "Template error + #{e}", :layout => true
      end
    else
      @page = Page.find(page)
      @pagetitle = @page.title
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
  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "FEED title"

    # the news items
    @blogposts = BlogPost.order("updated_at desc")

    # this will be our Feed's update timestamp
    @updated = @blogposts.first.updated_at unless @blogposts.empty?

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
    
  end
end
