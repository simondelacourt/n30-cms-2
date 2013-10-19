class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
    
  def index
    @users = User.all
    @pagetitle = 'Gebruikers'
  end
  def show
  end
  def destroy
  end
  def new
    @user = User.new
    @pagetitle = "Voeg gebruiker toe"
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_url
    else
      render :action => 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
    @pagetitle = "Gebruiker: #{@user.firstname}"
  end
  def update
    @user = User.find(params[:id])
    if params[:user][:password].length > 4
      updateuser = params[:user]
    else
      updateuser = {firstname: params[:user][:firstname], familyname: params[:user][:familyname], email: params[:user][:email]}
    end
    if @user.update_attributes(updateuser)
      redirect_to edit_admin_user_url(@user)
    else
      render :action => 'edit'
    end
  end
end
