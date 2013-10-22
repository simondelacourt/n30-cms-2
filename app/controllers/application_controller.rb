class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :preload
  def preload
    
    
    @title = ''
    @pagetitle = ''
    
    
    if current_user.nil?
      if User.all.count == 0
        u = User.new(:email => "admin@admin.com", :password => 'defaultpassword', :password_confirmation => 'defaultpassword')
        u.save!
      end
    end

    @appsettings = Hash.new
    Setting.all.each do |s|
      @appsettings[s.title] = s.settings
    end
    
    unless @appsettings['title'].nil?
      @title = @appsettings['title']
    end
    
    # not admin so load template, menu
    unless self.class.parent.inspect == 'Admin'
      # do any users exist?
      
      #load template
      @sitetemplate = Template.where(tdefault: true).take
      if @sitetemplate.nil?
        # no template? take first
        @sitetemplate = Template.first
      end
      
      # load menu
      @sitemenu = Menu.arrange(:order => :ordernum)
      begin
        respond_to do |format|
          format.html {@sitelayout = render_to_string(:inline => @sitetemplate.template, :layout => false, :locals => {:page => @sitemenu})}
        end
      rescue Exception => e
        @sitelayout = render_to_string :inline => "template error: #{e}", :layout => false
      end
      
      #sideloader for JS + CSS
      @sideloaderJS = Array.new
      @sideloaderCSS = Array.new
      
      # check if amount per pages
      if @appsettings['postsperpage'].nil?
        @appsettings['postsperpage'] = 15
      end
    else
      
    end
    
    
    
	
	
  end
end
