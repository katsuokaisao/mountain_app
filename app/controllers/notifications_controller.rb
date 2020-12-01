class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    reduce_query_notifications = current_user.passive_notifications.eager_load(:visited, :daily).preload(visitor: :profile)
    @notifications = reduce_query_notifications.where(visited_id: current_user.id).page(params[:page]).per(8)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
