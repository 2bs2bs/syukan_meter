require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    context 'success validation' do  
      it 'all_success' do
        user = create(:user)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
    end

    context 'failed validation' do
      it 'email null' do
        user = build(:user, email: '')
        expect(user).to be_invalid
        expect(user.errors[:email]).to eq ['を入力してください']
      end
      
      it 'password null' do
        user = build(:user, password: '')
        expect(user).to be_invalid
        expect(user.errors[:password]).to eq ['を入力してください', 'は3文字以上で入力してください']
      end

      it 'password_cofirmation null' do
        user = build(:user, password_confirmation: '')
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to eq ['とパスワードの入力が一致しません', 'を入力してください']
      end

      it 'not_mach password_confirmation' do
        user = build(:user, password_confirmation: 'pass')
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to eq ['とパスワードの入力が一致しません']
      end
      
      it 'email not_unique' do
        user  = create(:user)
        user2 = build(:user, email: user.email)
        expect(user2).to be_invalid
        expect(user2.errors[:email]).to eq ['はすでに存在します'] 
      end

      it 'password less than 3 characters' do
        user = build(:user, password: 'pa', password_confirmation: 'pa')
        expect(user).to be_invalid
        expect(user.errors[:password]).to eq ['は3文字以上で入力してください']
      end
    end
  end
end
