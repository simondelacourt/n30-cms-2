class Admin::SettingsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  def index
    @settings = Setting.all
    @pagetitle = 'Instellingen'
    
  end
  def edit
    @setting = Setting.find(params[:id])
    @pagetitle = "Wijzig #{@setting.title}"
  
  end
  def update
    @setting = Setting.find(params[:id])
    if @setting.update_attributes(params[:setting])
      redirect_to admin_settings_url
    else
      render action: 'edit'
    end
  end
  def new
    @setting = Setting.new
  end
  def create
    @setting = Setting.new(params[:setting])
    if @setting.save
      redirect_to edit_admin_setting_url(@setting)
    else
      redirect action: 'new'
    end
  end
  def resetsettings
    Setting.delete_all
    # all settings deleted, now resetting defaults
    
    def1 = Setting.new({:title => 'home', :settings => 'blog'})
    def1.save
    def2 = Setting.new({:title => 'title', :settings => 'site'})
    def2.save
    redirect_to admin_settings_url
    
  end
  def setashome
    if params[:page]
      @page = Page.friendly.find(params[:page])
      unless @page.nil?
        @setting = Setting.find_by_title('home')
        @setting.settings = "page_#{@page.slug}"
        if @setting.save
          redirect_to admin_page_url(@page)
        else
          redirect_to :action => 'index'
        end
      else
        redirect_to :action => 'index'
      end
    else
      redirect_to :action => 'index'
    end
  end
end
