require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  before do
    @user = FactoryBot.create(:user)
    profile = Profile.create(user_id: @user.id, introduce_text: "ここにプロフィール文を入れてください")
    sign_in @user
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_user_profiles_path(@user.id)
      expect(response).to have_http_status(:success)
    end
  end

end
