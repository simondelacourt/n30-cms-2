class Admin::TemplatesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  def index
    @templates = Template.find(:all)
    
  end
end
