class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :preload
  def preload
    @title = ''
    @pagetitle = ''
    
    # settings
    titlesetting = Setting.find_by_title('title')
    unless titlesetting.nil?
      @title = titlesetting.settings
    end
    
    # not admin so load template, menu
    unless self.class.parent.inspect == 'Admin'
      #load template
      @sitetemplate = Template.find_by_tdefault(true)
      if @sitetemplate.nil?
        # no template? take first
        @sitetemplate = Template.first
      end
      
      # load menu
      @sitemenu = Menu.arrange
    end
  end
end
