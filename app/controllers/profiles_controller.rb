class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :current_user?

  def edit
    @profile = current_user.profile || Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to edit_user_profiles_path(current_user.id)
    else
      redirect_to rot_path
    end
  end

  def update
    # プロフィールは存在する前提(userを作った時に自動で追加される)
    @profile = current_user.profile
    if @profile
      @profile.update(profile_params)
      redirect_to edit_user_profiles_path(current_user.id)
    else
      redirect_to root_path
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:introduce_text, :avatar)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
