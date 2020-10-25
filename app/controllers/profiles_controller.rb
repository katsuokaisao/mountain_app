class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :current_user?

  def edit
    @profile = @user.profile
  end

  def update 
    profile = Profile.find_by(id: @user.id)
    if profile.update(profile_params)
    redirect_to edit_user_profiles_path
    else 
      render 'edit'
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
