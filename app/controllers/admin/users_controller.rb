class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
    
  def index
    @users = User.find(:all)
  end
  def show
  end
  def destroy
  end
  def new
  end
  def create
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to edit_admin_user_url(@user)
    else
      render :action => 'edit'
    end
  end
end
