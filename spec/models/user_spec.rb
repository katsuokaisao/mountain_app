require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    before do
      @user = FactoryBot.build(:user)
    end
    it 'username, email, passwordがあれば有効' do
      expect(@user).to be_valid
    end
    it 'usernameがなければ無効' do
      @user.username = nil
      expect(@user).not_to be_valid
    end
    it 'emailがなければ無効' do
      @user.email = nil
      expect(@user).not_to be_valid
    end
    it 'passwordがなければ無効' do
      @user.password = nil
      expect(@user).not_to be_valid
    end
    it 'emailが重複すると無効' do
      @user.save
      other_user = FactoryBot.build(:user, email: @user.email)
      expect(other_user).not_to be_valid
    end
  end
end
