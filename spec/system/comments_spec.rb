require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let(:comment) { create(:comment) }
  let(:max_length) { 65_535 }

  describe 'ログイン前' do

  end

  describe 'ログイン後' do
    before{ login(user) }

    describe 'comment create' do
      before {
        visit post_path(post)
        click_on 'コメントする'
        expect(page).to have_selector('#new-comment-modal:not(.hidden)')
      }

      context 'input is correct' do
        it 'comment creata success' do
          fill_in 'comment_body', with: comment.body
          click_button 'コメントする'
          expect(page).to have_content comment.body
          expect(current_path).to eq post_path(post)
        end
      end

      context 'comment body is nil' do
        it 'comment create failed' do
          fill_in 'comment_body', with: ''
          click_button 'コメントする'
          expect(page).to have_content 'コメント内容を入力してください'
          expect(page).not_to have_content comment.body
        end
      end
      
      context 'comment body is over 65_536 charactors' do
        it 'comment create failed' do
          fill_in 'comment_body', with: 'a' * (max_length + 1)
          click_button 'コメントする'
          expect(page).to have_content 'コメント内容は65535文字以内で入力してください'
          expect(page).not_to have_content comment.body
        end
      end
    end

    describe 'comment delete' do
      let!(:comment) { create(:comment, post: post, user: user) }

      it 'comment delete success' do
        visit post_path(post)
        click_on 'delete-comment'
        expect(page.accept_confirm).to eq "コメントを削除しますか？"
        expect(page).not_to have_content comment.body
      end
    end
  end
end
