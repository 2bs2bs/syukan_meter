require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation check' do
    context 'validation success' do
      it 'post create' do
        post = build(:post)
        expect(post).to be_valid
        expect(post.errors).to be_empty
      end
    end
    
    context 'validation failed' do
      it 'body is not_null' do
        post = build(:post, body: '')
        expect(post).to be_invalid
        expect(post.errors[:body]).to eq ['を入力してください']
      end

      it 'body can be up to 255 charactors' do
        oversized_body = 'a' * 256
        post = build(:post, body: oversized_body)
        expect(post).to be_invalid
        expect(post.errors[:body]).to eq ['は255文字以内で入力してください']
      end
    end
  end
end
