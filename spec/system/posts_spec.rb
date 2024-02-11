require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe 'ログイン前' do
    context '投稿作成しようとする' do
      it 'login_request' do
        visit posts_path
        click_on '投稿する'
        expect(page).to have_selector('#new-post-modal:not(.hidden)')
        fill_in 'post[body]', with: post.body
        click_button '投稿する'
        expect(page).to have_content 'ログインしてね！'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe '投稿作成' do
      context '入力が適切' do
        it '投稿作成成功' do
          visit posts_path
          click_on '投稿する'
          expect(page).to have_selector('#new-post-modal:not(.hidden)')
          fill_in 'post[body]', with: 'テスト投稿の内容'
          click_button '投稿する'
          expect(page).to have_content '投稿しました！'
          expect(page).to have_content 'テスト投稿の内容'
          expect(page).to have_content post.created_at.strftime('%Y/%m/%d')
          expect(current_path).to eq posts_path
        end
      end

      context 'bodyが空白' do
        it '投稿作成失敗' do
          visit posts_path
          click_on '投稿する'
          expect(page).to have_selector('#new-post-modal:not(.hidden)')
          fill_in 'post[body]', with: ''
          click_button '投稿する'
          expect(page).to have_content '投稿に失敗しました'
        end
      end

      context '文字が256文字以上' do
        it '投稿作成失敗' do
          visit posts_path
          click_on '投稿する'
          expect(page).to have_selector('#new-post-modal:not(.hidden)')
          fill_in 'post[body]', with: 'a' * 256
          click_button '投稿する'
          expect(page).to have_content '投稿に失敗しました'
        end
      end
    end

    describe '投稿編集' do
      let!(:post) { create(:post, user: user) }
      let(:other_post) { create(:post, user: user) }
      # before { visit edit_post_path(post) }

      context '入力が適切' do
        it '投稿に編集ボタンがあるか確認' do
          visit posts_path
          expect(page).to have_content post.body
          expect(page).to have_link('', href: edit_post_path(post))
        end
        # it '編集成功' do
        #   fill_in 'post[body]', with: 'テスト編集'
        #   click_button '投稿する'
        #   expect(page).to have_content '投稿を更新しました！'
        #   expect(page).to have_content 'テスト編集'
        #   expect(page).to have_content post.created_at.strftime('%Y/%m/%d')
        #   expect(current_path).to eq posts_path
        # end
      end
    end

    describe '投稿削除' do
    end
  end
end
