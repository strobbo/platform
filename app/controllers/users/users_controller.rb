class Users::UsersController < ApplicationController
	load_and_authorize_resource

  def show
		@user = User.find(params[:id])
    render 'users/show'
  end

  def following
		@title = "Seguindo"
  	@user = User.find(params[:id])
		@users = @user.followed_users
    render 'users/show_follow'
  end

  def followers
		@title = "Seguidores"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'users/show_follow'
  end

end
