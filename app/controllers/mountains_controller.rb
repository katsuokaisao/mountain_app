class MountainsController < ApplicationController
  # ログインしてなくてもcurrent_userじゃなくても山情報は見れてもいい
  def index
    @mountains = Mountain.all
  end

  def show
    @mountain = Mountain.find(params[:id])
  end
end
