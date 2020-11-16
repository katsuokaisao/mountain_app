class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like

  def create 
    user = current_user
    unless @daily.user == user
      Like.create(user_id: user.id, daily_id: @daily.id)
      redirect_back fallback_location: root_path
    else
      flash[:danger] = "自分の投稿をいいねすることはできません"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    user = current_user
    unless @daily.user == user
      Like.find_by(user_id: user.id, daily_id: @daily.id).delete
      redirect_back fallback_location: root_path
    else
      flash[:danger] = "自分の投稿をいいね解除できません"
      redirect_back fallback_location: root_path
    end
  end

  private
    def set_like
      @daily = Daily.find(params[:daily_id])
    end
end
