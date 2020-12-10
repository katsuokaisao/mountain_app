require 'rails_helper'

RSpec.feature "Messages", type: :feature do
  describe "他ユーザーのマイページのテスト" do
    before do 
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
      sign_in @user
    end
    context "もし他ユーザーを相互フォローの時" do 
      before do 
        @user.follow(@other_user)
        @other_user.follow(@user)
      end
      context "チャットが初めての場合" do 
        it "チャットを始めるボタンが表示される" do
          # チャットルームを作成・チャットルームに移動
          visit user_dailys_own_path(@other_user)
          expect(page).to have_button 'チャットを始める'
          click_button 'チャットを始める'
          # 投稿
          fill_in 'message_text', with: "テストです。"
          click_on '投稿'
          visit current_path
          expect(page).to have_content 'テストです。'
          # 投稿の削除
          find('.trash-button').click
          visit current_path
          expect(page).not_to have_content 'テストです。'
          # チャット一覧ページ
          visit rooms_path
          expect(page).to have_selector 'div.chat-index'
          expect(page).to have_content @other_user.username
        end
      end
      context "これまでチャットをしたことがある場合" do
        it "チャットアイコンが表示される" do
          visit user_dailys_own_path(@other_user)
          click_button 'チャットを始める'
          visit user_dailys_own_path(@other_user)
          expect(page).to have_selector 'p.user-show-room'
        end
      end
    end

    context "もし他ユーザーを相互フォロでないとき" do
      it "チャットを始めるボタンが表示されない" do
        visit user_dailys_own_path(@other_user)
        expect(page).not_to have_button 'チャットを始める'
      end
    end
  end
end
