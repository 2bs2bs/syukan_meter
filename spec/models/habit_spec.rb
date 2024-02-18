require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe 'validation check' do
    context 'validation success' do
      it 'すべてのバリデーションが機能しているか' do
        habit = build(:habit)
        expect(habit).to be_valid
        expect(habit.errors).to be_empty
      end
    end

    context 'validation failed' do
      it 'name is nil' do
        habit = build(:habit, name: '')
        expect(habit).to be_invalid
        expect(habit.errors[:name]).to eq ['を入力してください']
      end

      it 'name over 255' do
        habit = build(:habit, name: 'a' * 256 )
        expect(habit).to be_invalid
        expect(habit.errors[:name]).to eq ['は255文字以内で入力してください']
      end

      it 'description over 1000' do
        habit = build(:habit, description: 'a' * 1001 )
        expect(habit).to be_invalid
        expect(habit.errors[:description]).to eq ['は1000文字以内で入力してください']
      end
      
      it 'start_date is nil' do
        habit = build(:habit, start_date: '' )
        expect(habit).to be_invalid
        expect(habit.errors[:start_date]).to eq ['を入力してください']
      end

      it 'end_date is nil' do
        habit = build(:habit, end_date: '' )
        expect(habit).to be_invalid
        expect(habit.errors[:end_date]).to eq ['を入力してください']
      end

      it 'start_date < today' do
        habit = build(:habit, start_date: Date.today - 1.days )
        expect(habit).to be_invalid
        expect(habit.errors[:start_date]).to eq ["当日以降を入力してください"]
      end

      it 'start_date > end_date' do
        habit = build(:habit)
        habit.end_date = habit.start_date - 5.days
        expect(habit).to be_invalid
        expect(habit.errors[:end_date]).to eq ["開始日以降を入力してください"]
      end
    end
  end
end
