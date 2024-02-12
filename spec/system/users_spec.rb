require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'user作成' do
      context '入力が適切' do
        it 'user登録成功' do
          visit new_user_path
          fill_in 'user_profile_attributes_user_name', with: 'test_user'
          fill_in 'user_email', with: 'email@example.com'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button '登録する'
          expect(page).to have_content '登録とログインしました！良い習慣を！'
          expect(current_path).to eq home_path
        end
      end

      context 'メールアドレスがnil' do
        it 'user登録失敗' do
        end
      end

      context 'メールアドレスがユニークじゃない' do
        it 'user登録失敗' do
        end
      end

      context 'passwordがnil' do
      end

      context 'password_confirmationがnil' do
      end

      context 'passwordとpassword_confirmationが3文字以下' do
      end

      context 'passwordとpassword_confirmationが一致しない' do
      end
    end

    describe 'user詳細' do
      context '自分のshowページにアクセス' do
      end
    end
  end

  describe 'ログイン後' do
    describe 'user詳細' do
      context '詳細ページにアクセス' do
        it 'アクセス成功' do
        end
      end
    end
  end
end
