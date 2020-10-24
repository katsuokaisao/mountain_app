class UsersController < ApplicationController 
  def following
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(8)
    render 'show_following'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(8)
    render 'show_followers'
  end
end