require 'rails_helper'

RSpec.describe "Dailys", type: :request do

  describe "GET /home" do
    it "returns http success" do
      get "/dailys/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /own" do
    it "returns http success" do
      get "/dailys/own"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /mountain" do
    it "returns http success" do
      get "/dailys/mountain"
      expect(response).to have_http_status(:success)
    end
  end

end
