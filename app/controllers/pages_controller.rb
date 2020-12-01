class PagesController < ApplicationController
  def home
    redirect_to user_dailys_own_path(current_user.id) if user_signed_in?
  end
end
