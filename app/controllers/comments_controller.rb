class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @comment = Comment.new
    @daily = Daily.find_by(id: params[:daily_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.daily_id = params[:daily_id]
    if @comment.save
      # @comment.userが@comment.daily.userに通知を送る
      @comment.daily.create_notification_coment!(@comment.user, @comment.id)
      redirect_to user_daily_path(@comment.user_id, @comment.daily_id)
    else
      @daily = Daily.find_by(id: params[:daily_id])
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :daily_id)
  end
end
