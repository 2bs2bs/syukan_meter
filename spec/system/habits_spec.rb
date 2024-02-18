require 'rails_helper'

RSpec.describe "Habits", type: :system do
  let(:user) { create(:user) }
  let!(:habit) { create(:habit) }

  describe 'ログイン前' do
    context '習慣作成しようとする' do
      it 'login_require' do
        visit habits_path
        expect(page).to have_content 'ログインしてね！'
        expect(current_path).to eq login_path
      end
    end
  end
  
  describe 'ログイン後' do
    before { login(user) }

    describe 'habit create' do
      context '入力が適切' do
        it '習慣作成成功' do
          visit habits_path
          click_on '習慣を作成する'
          expect(page).to have_selector('#new-habit-modal:not(.hidden)')
          fill_in 'habit_name', with: 'test_habit'
          fill_in 'habit_description', with: 'test_description'
          fill_in 'habit_start_date', with: Date.today
          fill_in 'habit_end_date', with: (Date.today + 30)
          click_button '登録する'
          expect(page).to have_content '習慣を作成しました！一緒にがんばりましょう！'
          expect(current_path).to eq habits_path
        end
      end

      context 'name is nil' do
        it 'create field' do
          visit habits_path
          click_on '習慣を作成する'
          expect(page).to have_selector('#new-habit-modal:not(.hidden)')
          fill_in 'habit_name', with: ''
          fill_in 'habit_description', with: habit.description
          fill_in 'habit_start_date', with: habit.start_date
          fill_in 'habit_end_date', with: habit.end_date
          click_button '登録する'
          expect(page).to have_content '習慣作成に失敗しました'
        end
      end

      context 'name over 255 charactors' do
        it 'create field' do
          visit habits_path
          click_on '習慣を作成する'
          expect(page).to have_selector('#new-habit-modal:not(.hidden)')
          fill_in 'habit_name', with: 'a' * 256
          fill_in 'habit_description', with: habit.description
          fill_in 'habit_start_date', with: habit.start_date
          fill_in 'habit_end_date', with: habit.end_date
          click_button '登録する'
          expect(page).to have_content '習慣作成に失敗しました'
        end
      end

      context 'description over 1000 charactors' do
        it 'create failed' do
          visit habits_path
          click_on '習慣を作成する'
          expect(page).to have_selector('#new-habit-modal:not(.hidden)')
          fill_in 'habit_name', with: ''
          fill_in 'habit_description', with: 'a' * 1001
          fill_in 'habit_start_date', with: habit.start_date
          fill_in 'habit_end_date', with: habit.end_date
          click_button '登録する'
          expect(page).to have_content '習慣作成に失敗しました'
        end
      end

      context 'start_date is nil' do
        it 'create failed' do
          visit habits_path
          click_on '習慣を作成する'
          expect(page).to have_selector('#new-habit-modal:not(.hidden)')
          fill_in 'habit_name', with: habit.name
          fill_in 'habit_description', with: habit.description
          fill_in 'habit_start_date', with: ''
          fill_in 'habit_end_date', with: habit.end_date
          click_button '登録する'
          expect(page).to have_content '習慣作成に失敗しました'
        end
      end

      context 'end_date is nil' do
        it 'create failed' do
          visit habits_path
          click_on '習慣を作成する'
          expect(page).to have_selector('#new-habit-modal:not(.hidden)')
          fill_in 'habit_name', with: habit.name
          fill_in 'habit_description', with: habit.description
          fill_in 'habit_start_date', with: habit.start_date
          fill_in 'habit_end_date', with: ''
          click_button '登録する'
          expect(page).to have_content '習慣作成に失敗しました'
        end
      end

      context 'start_date < Today' do
        it 'create failed' do
          visit habits_path
          click_on '習慣を作成する'
          expect(page).to have_selector('#new-habit-modal:not(.hidden)')
          fill_in 'habit_name', with: habit.name
          fill_in 'habit_description', with: habit.description
          fill_in 'habit_start_date', with: (habit.start_date - 1)
          fill_in 'habit_end_date', with: habit.end_date
          click_button '登録する'
          expect(page).to have_content '習慣作成に失敗しました'
        end
      end

      context 'start_date > end_date' do
        it 'create failed' do
          visit habits_path
          click_on '習慣を作成する'
          expect(page).to have_selector('#new-habit-modal:not(.hidden)')
          fill_in 'habit_name', with: habit.name
          fill_in 'habit_description', with: habit.description
          fill_in 'habit_start_date', with: habit.end_date
          fill_in 'habit_end_date', with: habit.start_date
          click_button '登録する'
          expect(page).to have_content '習慣作成に失敗しました'
        end
      end
    end

    describe 'habit edit' do
      let!(:habit) { create(:habit, user: user) }

      context '入力が適切' do
        it 'edit success' do
          visit edit_habit_path(habit)
          click_button '更新する'
          expect(page).to have_content '習慣をアップデートしました'
          expect(current_path).to eq habits_path
        end
      end

      context 'name is nil' do
        it 'edit failed' do
          visit edit_habit_path(habit)
          fill_in 'habit_name', with: ''
          click_button '更新する'
          expect(page).to have_content '習慣のアップデートに失敗しました'
          expect(page).to have_content '習慣名を入力してください'
          expect(current_path).to eq edit_habit_path(habit)
        end
      end

      context 'name is over 255 charactors' do
        it 'edit failed' do
          visit edit_habit_path(habit)
          fill_in 'habit_name', with: 'a' * 256
          click_button '更新する'
          expect(page).to have_content '習慣のアップデートに失敗しました'
          expect(page).to have_content '習慣名は255文字以内で入力してください'
          expect(current_path).to eq edit_habit_path(habit)
        end
      end

      context 'description is over 1000 charactors' do
        it 'edit failed' do
          visit edit_habit_path(habit)
          fill_in 'habit_description', with: 'a' * 1001
          click_button '更新する'
          expect(page).to have_content '習慣のアップデートに失敗しました'
          expect(page).to have_content 'は1000文字以内で入力してください'
          expect(current_path).to eq edit_habit_path(habit)
        end
      end

      context 'start_date is nil' do
        it 'edit failed' do
          visit edit_habit_path(habit)
          fill_in 'habit_start_date', with: ''
          click_button '更新する'
          expect(page).to have_content '習慣のアップデートに失敗しました'
          expect(page).to have_content 'を入力してください'
          expect(current_path).to eq edit_habit_path(habit)
        end
      end

      context 'end_date is nil' do
        it 'edit failed' do
          visit edit_habit_path(habit)
          fill_in 'habit_end_date', with: ''
          click_button '更新する'
          expect(page).to have_content '習慣のアップデートに失敗しました'
          expect(page).to have_content 'を入力してください'
          expect(current_path).to eq edit_habit_path(habit)
        end
      end

      context 'end_date < start_date' do
        it 'edit failed' do
          visit edit_habit_path(habit)
          fill_in 'habit_end_date', with: (habit.start_date - 1)
          click_button '更新する'
          expect(page).to have_content '習慣のアップデートに失敗しました'
          expect(page).to have_content '開始日以降を入力してください'
          expect(current_path).to eq edit_habit_path(habit)
        end
      end
    end

    describe 'habit destroy' do
      let!(:habit) { create(:habit, user: user) }

      it 'habit destory' do
        visit habits_path
        click_link 'Delete'
        expect(page.accept_confirm).to eq "「#{habit.name}」を削除しますか？"
        expect(page).to have_content '習慣を削除しました'
        expect(current_path).to eq habits_path
        expect(page).not_to have_content habit.name
      end
    end
  end
end
