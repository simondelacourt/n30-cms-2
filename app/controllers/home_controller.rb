class HomeController < ApplicationController
  def index
    @blogposts = BlogPost.order("updated_at desc")
    @bloggroups = BlogGroup.find(:all)
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
