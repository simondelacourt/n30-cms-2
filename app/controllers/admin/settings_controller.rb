class Admin::SettingsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  def index
    @settings = Setting.find(:all)
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
end
