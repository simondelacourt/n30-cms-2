class BlogController < ApplicationController
  def index
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
  end
  def show
    @blogtemplate = BlogTemplate.find_by_mode(true)
    if @blogtemplate.nil?
      # no template? take first
      @blogtemplate = BlogTemplate.first
    end
    
    
    @bloggroups = BlogGroup.find(:all)
    @blogpost = BlogPost.find(params[:id])
    
    begin
      render :inline => @blogtemplate.blog_read, :layout => true, :locals => {:blogposts => @blogposts, :bloggroups => @bloggroups}
    rescue ActionView::Template::Error => e
      render :inline => "Template error + #{e}", :layout => true
    end
  end
end
