class LikesController < ApplicationController
  before_action :authenticate_user!

  def create 
    user = current_user
    @daily = Daily.find(params[:daily_id])
    unless @daily.user == user
      Like.create(user_id: user.id, daily_id: @daily.id)
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path }
        format.js
      end
    else
      flash[:danger] = "自分の投稿をいいねすることはできません"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    user = current_user
    @daily = Daily.find(params[:daily_id])
    unless @daily.user == user
      Like.find_by(user_id: user.id, daily_id: @daily.id).delete
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path }
        format.js
      end
    else
      flash[:danger] = "自分の投稿をいいね解除できません"
      redirect_back fallback_location: root_path
    end
  end
end
