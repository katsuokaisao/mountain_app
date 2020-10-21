# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new_guest
    user = User.guest
    profile = Profile.create(user_id: user.id, introduce_text: "ここにプロフィール文を入れてください")
    profile.avatar.attach(io: File.open(Rails.root.join('app','assets', 'images', 'stockfoto_12670415.jpg')), filename: "stockfoto_12670415.jpg", content_type: "image/jpg")
    profile.save
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
