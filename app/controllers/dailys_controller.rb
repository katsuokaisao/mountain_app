class DailysController < ApplicationController
  def home
  end

  def own
  end

  def mountain
  end

  def new 
    @daily = Daily.new()
  end

  def create
    @daily = Daily.new(daily_create_params)
    if @daily.save
      flash[:success] = "投稿できました！"
      redirect_to dailys_own_path
    else
      flash[:danger] = "投稿に失敗しました。"
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 
  def daily_create_params
    params.require(:daily).permit(:mountain_name, :title, :comment, :user_id, :mountain_id)
  end
end
