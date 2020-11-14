require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe 'ユーザー登録' do
    before do
      visit new_user_registration_path
      fill_in 'ユーザー名', with: 'foobarbaz'
      fill_in 'メールアドレス', with: 'baz@example.com'
    end
    context '正しい値が入力された時' do
      it '自分の日記投稿ページに遷移しない' do
        fill_in 'パスワード', with: 'foobar'
        fill_in 'パスワード再確認', with: 'foobar'
        click_button '新規登録'
        expect(page).to have_selector 'div#wrapper-for-ajax'
        # current_userがつかえなかったのでpathで確認するのは断念
        # div#wrapper-for-ajaxはhomeもしくはownページであることは検証できるが、ownページであるかは検証できない
        # 細かい確認はmodel specでテストする(feautre specでやると重たくなるから)
      end
    end
    context '不正な値が入力された時' do
      it '新規登録ページから遷移しない' do
        fill_in 'パスワード', with: 'bazbaz'
        fill_in 'パスワード再確認', with: 'foobar'
        click_button '新規登録'
        expect(current_path).to eq '/users'
        expect(page).to have_field 'ユーザー名' , with: 'foobarbaz'
        expect(page).to have_field 'メールアドレス', with: 'baz@example.com'
      end
    end
  end
  describe 'ログイン' do
    before do
      user = FactoryBot.create(:user, email: 'SignIn@exapmle.com', password: 'signin' )
      profile = Profile.create(user_id: user.id, introduce_text: "ここにプロフィール文を入れてください")
      visit new_user_session_path  
      fill_in 'メールアドレス', with: 'SignIn@exapmle.com' 
    end
    context '正しい値が入力された時' do 
      it '自分の日記投稿ページに遷移する' do
        fill_in 'パスワード', with: 'signin'
        click_button 'ログイン'
        expect(page).to have_selector 'div#wrapper-for-ajax'
      end
    end
    context '不正な値が入力された時' do 
      it 'ログインページから遷移しない' do 
        fill_in 'パスワード', with: 'a'
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_field 'メールアドレス', with: 'SignIn@exapmle.com'
      end
    end
  end
  describe 'ゲストログイン' do
    it '自分の日記投稿ページに遷移する' do
      visit root_path
      click_link 'ゲストログイン'
      expect(page).to have_selector 'div#wrapper-for-ajax'
    end
  end
end
