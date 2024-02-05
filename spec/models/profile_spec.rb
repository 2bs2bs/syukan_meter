require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validatioin check' do
    context 'validation success' do
      it 'profile success' do
        profile = build(:profile)
        expect(profile).to be_valid
        expect(profile.errors).to be_empty
      end
    end

    context 'validation failed' do
      it 'user_name null' do
        profile = build(:profile, user_name: '')
        expect(profile).to be_invalid
        expect(profile.errors[:user_name]).to eq ['を入力してください']
      end
    end
  end
end
