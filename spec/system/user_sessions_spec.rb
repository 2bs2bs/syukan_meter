require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do

    context '入力が適切' do
      it 'ログイン成功' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました！良い習慣を！'
        expect(current_path).to eq home_path
      end
    end
    
    context 'メールアドレスがnil' do
      it 'ログイン失敗' do
        visit login_path
        fill_in 'email', with: ''
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログイン失敗しました'
        expect(current_path).to eq login_path
      end
    end

    context 'パスワードがnil' do
      it 'ログイン失敗' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'ログイン失敗しました'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウト' do
      it 'ログアウト成功' do
        login(user)

        # フラッシュメッセージを確認しないとテスト失敗するため注意
        expect(page).to have_content 'ログインしました！良い習慣を！'
        
        visit home_path
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq root_path
      end
    end
  end
end
