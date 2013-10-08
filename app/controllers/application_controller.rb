class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :preload
  def preload
    
    
    @title = ''
    @pagetitle = ''
    
    
    if current_user.nil?
      if User.find(:all).count == 0
        u = User.new(:email => "admin@admin.com", :password => 'defaultpassword', :password_confirmation => 'defaultpassword')
        u.save!
      end
    end

    
    # settings
    titlesetting = Setting.find_by_title('title')
    unless titlesetting.nil?
      @title = titlesetting.settings
    end
    
    # not admin so load template, menu
    unless self.class.parent.inspect == 'Admin'
      # do any users exist?
      
      #load template
      @sitetemplate = Template.find_by_tdefault(true)
      if @sitetemplate.nil?
        # no template? take first
        @sitetemplate = Template.first
      end
      
      # load menu
      @sitemenu = Menu.arrange(:order => :ordernum)
      
      begin
        @sitelayout = render_to_string :inline => @sitetemplate.template, :layout => false, :locals => {:page => @sitemenu}
      rescue Exception => e
        @sitelayout = render_to_string :inline => "template error + #{e.inspect}", :layout => false
      end
      
      #sideloader for JS + CSS
      
      @sideloaderJS = Array.new
      @sideloaderCSS = Array.new
      
      # load settings
      
      @appsettings = Hash.new
      Setting.find(:all).each do |s|
        @appsettings[s.title] = s.settings
      end
      
      unless @appsettings[:title].nil?
        @title = @appsettings[:title]
      end
      
    else
      
    end
    
    
    
	
	
  end
end
