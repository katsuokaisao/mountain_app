require 'rails_helper'

RSpec.feature "FollowAndUnfollows", type: :feature do
  before do 
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
  end
  describe "フォローページのテスト" do
    context "ログインしているとき" do
      before do 
        @user.follow(@other_user)
        sign_in @user
        visit following_user_path(@user.id)
      end
      it "フォローしている人やフォロー中が表示される" do 
        expect(page).to have_selector "div.friends-list"  
        expect(page).to have_button "フォロー中"
      end
      it "フォロ中をクリックするとフォローボタンが表示される" do
        click_on "フォロー中"
        visit current_path
        # @other_userをフォローした後にアンフォローするとフォローしている人がひとりもいなくなるため
        expect(page).to have_content "まだ誰もフォローしていません。"
      end
    end
    
    context "ログインしていないとき" do
      before do 
        @user.follow(@other_user)
        visit following_user_path(@user.id)
      end
      it "ログインページにリダイレクトされる" do
        expect(current_path).to eq user_session_path
      end
    end

  end

  describe "フォロワーページのテスト" do
    before do
      @other_user.follow(@user)
    end
    context "ログインしているとき" do
      before do 
        sign_in @user
        visit followers_user_path(@user.id)
      end
      it "フォロワーが表示される" do 
        expect(page).to have_selector "div.friends-list"  
      end
    end
    
    context "ログインしていないとき" do
      it "ログインページにリダイレクトされる" do
        visit followers_user_path(@user.id)
        expect(current_path).to eq user_session_path
      end
    end
  end

  describe "他の人のマイページのテスト " do
    before do
      sign_in @user
    end
    context "フォローしているとき" do 
      it "フォロー中ボタンが表示される" do
        @user.follow(@other_user)
        visit user_dailys_own_path(@other_user)
        expect(page).to have_button "フォロー中"  
      end
    end
    context "フォローしていないとき" do
      it "フォローボタンが表示される" do
        visit user_dailys_own_path(@other_user)
        expect(page).to have_button "フォロー"
      end
    end
  end
end
