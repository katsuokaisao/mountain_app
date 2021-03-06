class MountainsController < ApplicationController
  # ログインしてなくてもcurrent_userじゃなくても山情報は見れてもいい
  def index
    @search = Mountain.ransack(params[:q])
    @mountains = @search.result(distinct: true)
    # @mountains = Mountain.all
  end

  def show
    @mountain = Mountain.find(params[:id])
    @api_key = Rails.application.credentials.api_key[:GOOGLEMAP]
  end

  def map
    @mountains = Mountain.all
    @api_key = Rails.application.credentials.api_key[:GOOGLEMAP]
  end
end
