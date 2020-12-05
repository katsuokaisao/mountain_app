require 'rails_helper'

RSpec.describe "Rooms", type: :request do

  before do
    @user = FactoryBot.create(:user)
    profile = Profile.create(user_id: @user.id, introduce_text: 'ここにプロフィール文を入れてください')
    sign_in @user
  end

  describe "GET /index" do
    it "returns http success" do
      get rooms_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    before do
      @room = Room.create
      Entry.create!(room_id: @room.id, user_id: @user.id)
    end
    it "returns http success" do
      get room_path(@room.id)
      expect(response).to have_http_status(:success)
    end
  end

end
