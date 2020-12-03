class MessagesController < ApplicationController
  # protect_from_forgery :except => [:destroy]
  def create
    entry = Entry.where(user_id: current_user.id, room_id: params[:message][:room_id])
    if entry.present?
      current_user.messages.create(message_params)
      @messages = entry.first.room.messages
    else
      flash[:alert] = "メッセージの送信に失敗しました！"
    end
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy if message.present?
    @messages = message.room.messages
    respond_to do |format|
      format.html {     redirect_back(fallback_location: room_path(message.room.id)) }
      format.js
    end
  end

  private 
    def message_params 
      params.require(:message).permit(:text, :room_id)
    end
end
