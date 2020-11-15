class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if resource.class == AdminUser
      admin_root_path
    else
      user_dailys_own_path(resource)
    end
  end

  def current_user?
    unless current_user == @user
      redirect_to root_path
    end
  end 
end
