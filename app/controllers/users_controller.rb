class UsersController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_user
  before_action :current_user?

  def following
    @users = @user.following.page(params[:page]).per(8).eager_load(profile: :avatar_attachment)
    render 'show_following'
  end

  def followers
    @users = @user.followers.page(params[:page]).per(8).eager_load(profile: :avatar_attachment)
    render 'show_followers'
  end

  private 
  def set_user
    @user = User.find(params[:id])
  end
end