class RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @entries = current_user.entries
  end

  def show
    # ルームのメッセージの表示
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.order("created_at asc")
      @message = @room.messages.build
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    # ルームの作成とエントリーの作成
    room = Room.create
    Entry.create(user_id: current_user.id, room_id: room.id)
    Entry.create(chat_params.merge(room_id: room.id))
    redirect_to room_path(room.id)
  end

  private 
    def chat_params
      params.require(:entry).permit(:user_id)
    end

end
