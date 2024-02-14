require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation check' do
    let(:comment) { build(:comment) }
    context 'validation success' do
      it 'validation thrue' do
        expect(comment).to be_valid
        expect(comment.errors).to be_empty
      end
    end

    context 'validation failed' do
      it 'body is nil' do
        comment.body = nil
        expect(comment).to be_invalid
        expect(comment.errors[:body]).to eq ["を入力してください"]
      end

      it 'body over 65_535' do
        comment.body = 'a' * 65_536
        expect(comment).to be_invalid
        expect(comment.errors[:body]).to eq ["は65535文字以内で入力してください"]
      end
    end
  end
end
