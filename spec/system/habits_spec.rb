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
          fill_in 'habit_name', with: ''
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
    end

    describe 'habit delstroy' do
    end
  end
end
