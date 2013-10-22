class HomeController < ApplicationController
  def index
    if @appsettings['home'].nil?
      home = 'blog'
    else
      if @appsettings['home'] == 'blog'
        home = 'blog'
      else
        page = @appsettings['home'][5..-1]
      end
    end
    if home == 'blog'
      @blogtemplate = BlogTemplate.where(mode: true).take
      if @blogtemplate.nil?
        # no template? take first
        @blogtemplate = BlogTemplate.first
      end
      @blogposts = BlogPost.paginate(:page => params[:page], :per_page => @appsettings['postsperpage'].to_i).where("status = 'published'").order("created_at desc")
      @bloggroups = nil
      @bloggroups = BlogGroup.all
      begin
        render :inline => @blogtemplate.blog_index, :layout => true, :locals => {:blogposts => @blogposts, :bloggroups => @bloggroups}
      rescue ActionView::Template::Error => e
        render :inline => "Template error: #{e}", :layout => true
      end
    else
      begin
        @page = Page.friendly.find(page)
      rescue ActiveRecord::RecordNotFound
         return render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
      end
      @pagetitle = @page.title
      @ids = [@page.id]
      #embeddables
      if @page.sourcefromchildren
        @page.descendants.each do |d|
          @ids.push d.id
        end
        embeddables = Embeddable.where(page_id: @ids).order('sortorder ASC')
      else
        embeddables = Embeddable.where(page_id: @page.id).order('sortorder ASC')
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
        render :inline => "Template error: #{e}", :layout => true
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
