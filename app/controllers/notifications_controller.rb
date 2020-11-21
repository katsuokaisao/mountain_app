class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index 
    @notifications = current_user.passive_notifications.eager_load(:visitor, :visited, :daily).where(visitor_id: current_user.id).page(params[:page]).per(8)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
