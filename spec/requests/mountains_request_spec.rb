require 'rails_helper'

RSpec.describe 'Mountains', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get mountains_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get mountain_path(50)
      expect(response).to have_http_status(:success)
    end
  end
end
