require 'rails_helper'

RSpec.describe "Dailys", type: :request do
  
  before do
    @user = FactoryBot.create(:user)
    profile = Profile.create(user_id: @user.id, introduce_text: "ここにプロフィール文を入れてください")
    sign_in @user
  end

  describe "GET /home" do
    it "returns http success" do
      get user_dailys_home_path(@user.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /own" do
    it "returns http success" do
      get user_dailys_own_path(@user.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /mountain" do
    it "returns http success" do
      get user_dailys_mountain_path(@user.id)
      expect(response).to have_http_status(:success)
    end
  end

end
