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
        fill_in '内容', with: '初めて富士山で日本一標高の高い山で自分1人で登れるかとても不安でした。5合目までは車で登ってきていて既に森林限界から脱していることに気付きました。あれ、ここ５合目だよなって一瞬なりましたが、富士山の標高を考えれば５合目で森林限界を超えていてもおかしくないですよね笑。森林限界を抜けるまでが一番きついので少し特をした気分になりました。それでも道が険しくて過酷な登山になるだろうと予想でき少し憂鬱した。しかし、なんと道も楽でした。アスファルトが砂利に変わっただけじゃないかと言うくらい道が整備されていて空気が少し薄いことを除けばほぼ下界と変わりませんでした。そんなこんなで登る前の不安は杞憂に終わりあっけなく登れたのでありますが、山頂での朝日は別格でした。知名度が高く富士山に登ったといえば誰もが興味を持ってもらえますし、朝日が綺麗というご褒美がある、だからと言って登るのもそこまでつらくはないという恐ろしくコスパの良い山でした。普段登山をしている人には物足りないかもしれませんが、もしくは富士山はみる山で登る山ではないと考えている方もいると思います。ただ、標高が日本一高い山他に登る理由は必要でしょうか。必要ないですよね笑。是非まだ富士山に登っていない方は老若男女問わず一度登ってみることをお勧めいたします。'
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
