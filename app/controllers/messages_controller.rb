class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = current_user.messages.create(message_params)
      redirect_to room_path @message.room_id
    else
      flash[:alert] = "メッセージの送信に失敗しました！"
    end
  end

  def destroy
  end

  private 
    def message_params 
      params.require(:message).permit(:text, :room_id)
    end
end
