class DailysController < ApplicationController
  # own以外で他の人のページにアクセスできないし、アクセスできても
  # createやupdate、deleteができないようにする
  before_action :authenticate_user!
  before_action :set_user, except: [:mountain, :mountain_show]
  before_action :current_user?, except: [:own, :show, :mountain, :mountain_show]
  before_action :set_daily, only: [:show, :destroy]

  def home
    # current_userとcurrent_userがフォローしている人の投稿一覧
    following_ids = @user.following_ids
    id = @user.id
    @dailys = Daily.where("user_id IN (?) OR user_id = ?", following_ids, id).eager_load( :mountain).preload({user: {profile: :avatar_attachment}}, :images_attachments).page(params[:page]).without_count.per(50)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def own
    @dailys = @user.dailys.page(params[:page]).eager_load(:user, :mountain).preload(:images_attachments).without_count.per(50)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def mountain_show
    mountain = Mountain.find(params[:mountain_id])
    @dailys = mountain.dailys.eager_load(user: {profile: :avatar_attachment})
  end

  def mountain
    @search = Mountain.ransack(params[:q])
    @mountains = @search.result(distinct: true)
  end

  def new 
    @daily = Daily.new
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
    @comments = @daily.comments.eager_load(:user)
  end

  def destroy
    if @user.dailys.include?(@daily)
      flash[:success] = "投稿を削除しました"
      @daily.destroy
      redirect_to root_path
    else
      flash[:danger] = "他の人の投稿は削除できません"
      redirect_to root_path
    end
  end

  private 
  def daily_create_params
    params.require(:daily).permit(:mountain_name, :title, :comment, images: []).merge(user_id: current_user.id, mountain_id: 1)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_daily
    @daily = Daily.find(params[:id])
  end
end
