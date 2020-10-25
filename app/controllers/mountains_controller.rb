class MountainsController < ApplicationController
  # ログインしてなくても山情報は見れてもいいかも
  def index
    @mountains = Mountain.all
  end

  def show
    @mountain = Mountain.find(params[:id])
  end
end
