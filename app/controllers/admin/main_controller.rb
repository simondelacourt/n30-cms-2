class Admin::MainController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin'
  def index
    @blogposts = BlogPost.all.order('created_at DESC').limit(5)
    @pagetitle = 'Welkom'
  end
end