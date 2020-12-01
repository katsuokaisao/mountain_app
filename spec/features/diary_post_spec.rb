require 'rails_helper'

RSpec.feature 'DiaryPosts', type: :feature do
  describe '日記投稿' do
    before do
      @user = FactoryBot.create(:user)
      profile = Profile.create(user_id: @user.id, introduce_text: 'ここにプロフィール文を入れてください')
      sign_in @user
      visit new_user_daily_path(@user.id)
    end
    context '適切な値が入力された時' do
      it '自分の日記一覧ページに遷移する' do
        expect(page).to have_content '投稿する'
        select '富士山', from: '山の名前'
        fill_in 'タイトル', with: '富士山に行ってみた'
        fill_in '内容', with: '初めて富士山で日本一標高の高い山で自分1人で登れるかとても不安でした。5合目までは車で登ってきていて既に森林限界から脱していることに気付きました。'
        click_button '投稿する'
        expect(current_path).to eq user_dailys_own_path(@user.id)
      end
    end
    context '不適切な値が入力された時' do
      it '投稿ページから遷移しない' do
        select '富士山', from: '山の名前'
        fill_in 'タイトル', with: '富士山に行ってみた'
        fill_in '内容', with: ''
        click_button '投稿する'
        expect(current_path).to eq "/users/#{@user.id}/dailys"
        expect(page).to have_field '山の名前', with: '富士山'
        expect(page).to have_field 'タイトル', with: '富士山に行ってみた'
      end
    end
  end
  describe '投稿した日記の削除' do
    before do
      @user = FactoryBot.create(:user)
      @profile = FactoryBot.create(:profile, user_id: @user.id)
      @daily = FactoryBot.create(:daily, user_id: @user.id)
      sign_in @user
    end
    context '自分の投稿の場合' do
      it '削除できる' do
        visit user_daily_path(@user.id, @daily.id)
        expect { find('.trash-button').click }.to change { @user.dailys.count }.by(-1)
        expect(current_path).to eq user_dailys_own_path(@user.id)
      end
    end
    context '自分以外の投稿の場合' do
      it 'そもそも削除ボタンが存在しない' do
        other_user = FactoryBot.create(:user)
        FactoryBot.create(:profile, user_id: other_user.id)
        other_daily = FactoryBot.create(:daily, user_id: other_user.id)
        visit user_daily_path(other_user.id, other_daily.id)
        expect(page).not_to have_selector '.trash-button'
        # 投稿が削除できないかはmodel specに移譲
      end
    end
  end
end
