class PagesController < ApplicationController
  def home
    redirect_to dailys_own_path if user_signed_in? 
  end
end
