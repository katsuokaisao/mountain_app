class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def edit
    user = User.find_by(id: current_user.id)
    @profile = user.profile
  end

  def update 
    profile = Profile.find(params[:user_id])
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
end
