require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation check' do
    let(:comment) { build(:comment) }

    context 'validation success' do
      it 'passes all validations' do
        expect(comment).to be_valid
        expect(comment.errors).to be_empty
      end
    end

    context 'validation failed' do
      it 'fails validation when body is nil' do
        comment.body = nil
        expect(comment).to be_invalid
        expect(comment.errors[:body]).to include("を入力してください")
      end

      it 'fails validation when body length is over 65,535 characters' do
        comment.body = 'a' * (Comment.validators_on(:body).find { |v| v.options[:maximum] }.options[:maximum] + 1)
        expect(comment).to be_invalid
        expect(comment.errors[:body]).to include("は65535文字以内で入力してください")
      end
    end
  end
end