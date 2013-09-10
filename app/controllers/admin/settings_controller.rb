class Admin::SettingsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  def index
    @settings = Setting.find(:all)
  end
  def edit
    @setting = Setting.find(params[:id])
  end
  def update
    
  end
end
