require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Comment#create' do
    let(:comment) { build(:comment) }

    context '正常に作成される時' do
      it '有効になること' do
        expect(comment).to be_valid
        expect(comment.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'bodyがなければ無効' do
        comment.body = nil
        expect(comment).to be_invalid
        expect(comment.errors[:body]).to eq ["を入力してください"]
      end

      it 'bodyが65_535文字より多いなら無効' do
        comment.body = 'a' * 65536
        expect(comment).to be_invalid
        expect(comment.errors[:body]).to eq ["は65535文字以内で入力してください"]
      end
    end
  end
end
