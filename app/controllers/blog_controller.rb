class BlogController < ApplicationController
  def index
    @blogtemplate = BlogTemplate.where(mode: true).take
    if @blogtemplate.nil?
      # no template? take first
      @blogtemplate = BlogTemplate.first
    end
  

    
    @blogposts = BlogPost.paginate(:page => params[:page], :per_page => @appsettings['postsperpage'].to_i).where("status = 'published'").order("created_at desc")
    @bloggroups = BlogGroup.all
    
    
    begin
      render :inline => @blogtemplate.blog_index, :layout => true, :locals => {:blogposts => @blogposts, :bloggroups => @bloggroups}
    rescue ActionView::Template::Error => e
      render :inline => "Template error + #{e}", :layout => true
    end
  end
  def show
    @blogtemplate = BlogTemplate.where(mode: true).take
    if @blogtemplate.nil?
      # no template? take first
      @blogtemplate = BlogTemplate.first
    end
    
    @bloggroups = BlogGroup.all
    @blogpost = BlogPost.find(params[:id])
    
    begin
      render :inline => @blogtemplate.blog_read, :layout => true, :locals => {:blogposts => @blogposts, :bloggroups => @bloggroups}
    rescue ActionView::Template::Error => e
      render :inline => "Template error + #{e}", :layout => true
    end
  end
  def search
    @blogtemplate = BlogTemplate.find_by_mode(true)
    if @blogtemplate.nil?
      # no template? take first
      @blogtemplate = BlogTemplate.first
    end
    
    
    @bloggroups = BlogGroup.all
    
    page_num = 1
    if params[:page] && !params[:page].empty?
      page_num = params[:page]
    end
    
    @blogposts = BlogPost.search do
      fulltext params[:query]
      paginate :page => page_num, :per_page => 10
    end
    
    
    
    begin
      render :inline => @blogtemplate.blog_search, :layout => true, :locals => {:blogposts => @blogposts, :bloggroups => @bloggroups}
    rescue ActionView::Template::Error => e
      render :inline => "Template error + #{e}", :layout => true
    end
    
  end
end
