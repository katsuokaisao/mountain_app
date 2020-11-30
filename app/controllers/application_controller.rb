class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def after_sign_in_path_for(resource)
    if resource.instance_of?(AdminUser)
      admin_admin_users_path
    else
      user_dailys_own_path(resource)
    end
  end

  def current_user?
    redirect_to root_path unless current_user == @user
  end
end
