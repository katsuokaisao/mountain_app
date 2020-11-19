class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = current_user #勝手に他の人のフォロ・アンフォローをしない
    @other_user = User.find_by(id: params[:followed_id])
    current_user.follow(@other_user) unless @user == @other_user
    respond_to do |format|
      format.html { redirect_back fallback_location: following_user_path(@user.id) }
      format.js
    end
  end

  def destroy
    @user = current_user
    @other_user = User.find_by(id: params[:followed_id])
    @user.unfollow(@other_user) unless @user == @other_user
    respond_to do |format|
      format.html { redirect_back fallback_location: following_user_path(@user.id) }
      format.js
    end
  end
end
