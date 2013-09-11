class Admin::JavascriptsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  
  def index
  end

  def edit
  end

  def new
  end
end
