class LikesController < ApplicationController
  before_action :authenticate_user!

  def create 
    user = current_user
    @daily = Daily.find(params[:daily_id])
    Like.create(user_id: user.id, daily_id: @daily.id)
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end

  def destroy
    user = current_user
    @daily = Daily.find(params[:daily_id])
    Like.find_by(user_id: user.id, daily_id: @daily.id).delete
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end
end
