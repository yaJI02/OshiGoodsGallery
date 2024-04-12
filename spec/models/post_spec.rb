require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post#create' do
    let(:post) { build(:post) }

    context '正常に作成される時' do
      it '有効になること' do
        expect(post).to be_valid
        expect(post.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'titleがなければ無効' do
        post.title = nil
        expect(post).to be_invalid
        expect(post.errors[:title]).to eq ["を入力してください"]
      end

      it 'titleが255文字より多いなら無効' do
        post.title = 'a' * 256
        expect(post).to be_invalid
        expect(post.errors[:title]).to eq ["は255文字以内で入力してください"]
      end

      it 'bodyが65_535文字より多いなら無効' do
        post.body = 'a' * 65536
        expect(post).to be_invalid
        expect(post.errors[:body]).to eq ["は65535文字以内で入力してください"]
      end

      it 'purchase_costが255文字より多いなら無効' do
        post.purchase_cost = '1' * 256
        expect(post).to be_invalid
        expect(post.errors[:purchase_cost]).to eq ["は255文字以内で入力してください"]
      end

      it 'post_typeがなければ無効' do
        post.post_type = nil
        expect(post).to be_invalid
        expect(post.errors[:post_type]).to eq ["を入力してください"]
      end

      it 'purchase_statusがなければ無効' do
        post.purchase_status = nil
        expect(post).to be_invalid
        expect(post.errors[:purchase_status]).to eq ["を入力してください"]
      end

      it 'display_commentがなければ無効' do
        post.display_comment = nil
        expect(post).to be_invalid
        expect(post.errors[:display_comment]).to eq ["は一覧にありません"]
      end
    end
  end
end
