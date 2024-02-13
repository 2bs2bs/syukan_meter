require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user, email: 'not_unique@com') }

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

      context 'user_nameがnil' do
        it 'user登録失敗' do
          visit new_user_path
          fill_in 'user_profile_attributes_user_name', with: ''
          fill_in 'user_email', with: 'email@example.com'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'ユーザー名を入力してください'
          expect(current_path).to eq new_user_path
        end
      end

      context 'メールアドレスがnil' do
        it 'user登録失敗' do
          visit new_user_path
          fill_in 'user_profile_attributes_user_name', with: 'test_user'
          fill_in 'user_email', with: ''
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(current_path).to eq new_user_path
        end
      end

      context 'メールアドレスがユニークじゃない' do
        it 'user登録失敗' do
          visit new_user_path
          fill_in 'user_profile_attributes_user_name', with: 'test_user'
          fill_in 'user_email', with: other_user.email
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(current_path).to eq new_user_path
        end
      end

      context 'passwordがnil' do
        it 'user登録失敗' do
          visit new_user_path
          fill_in 'user_profile_attributes_user_name', with: 'test_user'
          fill_in 'user_email', with: 'email@example.com'
          fill_in 'user_password', with: ''
          fill_in 'user_password_confirmation', with: 'password'
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'パスワードを入力してください'
          expect(page).to have_content 'パスワードは3文字以上で入力してください'
          expect(current_path).to eq new_user_path
        end
      end

      context 'password_confirmationがnil' do
        it 'user登録失敗' do
          visit new_user_path
          fill_in 'user_profile_attributes_user_name', with: 'test_user'
          fill_in 'user_email', with: 'email@example.com'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: ''
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'パスワード確認を入力してください'
          expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
          expect(current_path).to eq new_user_path
        end
      end

      context 'passwordとpassword_confirmationが3文字以下' do
        it 'user登録失敗' do
          visit new_user_path
          fill_in 'user_profile_attributes_user_name', with: 'test_user'
          fill_in 'user_email', with: 'email@example.com'
          fill_in 'user_password', with: 'pa'
          fill_in 'user_password_confirmation', with: 'pa'
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'パスワードは3文字以上で入力してください'
          expect(current_path).to eq new_user_path
        end
      end

      context 'passwordとpassword_confirmationが一致しない' do
        it 'user登録失敗' do
          visit new_user_path
          fill_in 'user_profile_attributes_user_name', with: 'test_user'
          fill_in 'user_email', with: 'email@example.com'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'pass'
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
          expect(current_path).to eq new_user_path
        end
      end
    end
  end
end
