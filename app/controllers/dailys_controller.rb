class DailysController < ApplicationController
  # 最初のpagesコントローラー以外はログイン必要
  # ownアクション以外は以外はcurrent_userである必要があるよね
  # own以外で他の人のページにアクセスできないし、アクセスできても
  # createやupdate、deleteができないようにする
  
  def home
    # current_userとcurrent_userがフォローしている人の投稿一覧
    @user = User.find(params[:user_id])
    following_ids = @user.following_ids
    id = @user.id
    @dailys = Daily.where("user_id IN (?) OR user_id = ?", following_ids, id).page(params[:page]).per(8)
  end

  def own
    # current_userに限らずそのページのuser自身の投稿一覧
    @user = User.find(params[:user_id])
    @dailys = @user.dailys.page(params[:page]).per(6)
  end

  def mountain_show
    mountain = Mountain.find(params[:mountain_id])
    @dailys = mountain.dailys
  end

  def mountain
    # ここはただ山一覧を表示
    # ここから各山の投稿一覧に飛ぶ
    @mountains = Mountain.all
  end

  def new 
    @daily = Daily.new()
  end

  def create
    @daily = Daily.new(daily_create_params)
    mountains = Mountain.all
    name_matched_mountain = mountains.select { 
      |mountain| mountain.name == @daily.mountain_name
    }
    if name_matched_mountain.first && @daily.valid?
      flash[:success] = "投稿できました！"
      @daily.mountain_id = name_matched_mountain.first.id
      @daily.save
      redirect_to user_dailys_own_path
    else
      flash[:danger] = "投稿に失敗しました。"
      render 'new'
    end
  end

  def show 
  end

  def destroy
  end

  private 
  def daily_create_params
    params.require(:daily).permit(:mountain_name, :title, :comment, :user_id, :mountain_id, images: [])
  end
end
