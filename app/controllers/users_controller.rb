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

  def likes
    if @user == current_user
      paginate_like_posts = current_user.like_posts.page(params[:page]).per(8)
      @dailys = paginate_like_posts.eager_load({ user: { profile: :avatar_attachment } }, :mountain).preload(:images_attachments)
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_back
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
