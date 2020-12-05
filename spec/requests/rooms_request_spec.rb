require 'rails_helper'

RSpec.describe "Rooms", type: :request do

  before do
    @user = FactoryBot.create(:user)
    profile = Profile.create(user_id: @user.id, introduce_text: 'ここにプロフィール文を入れてください')
    sign_in @user
    @room = Room.create
  end

  describe "GET /index" do
    it "returns http success" do
      get rooms_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get room_path(@room.id)
      expect(response).to have_http_status(:success)
    end
  end

end
