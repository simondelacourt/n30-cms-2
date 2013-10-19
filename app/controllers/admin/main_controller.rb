class Admin::MainController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin'
  def index
    @blogposts = BlogPost.find(:all, :order => 'created_at DESC', :limit => '5')
    @pagetitle = 'Welkom'
  end
end