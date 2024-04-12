require 'rails_helper'

RSpec.describe PostStamp, type: :model do
  describe 'PostStamp#create' do
    context '正常に作成される時' do
      it '有効になること' do
        post_stamp = build(:post_stamp)
        expect(post_stamp).to be_valid
        expect(post_stamp.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'stampがなければ無効' do
        post_stamp = build(:post_stamp, stamp: nil)
        expect(post_stamp).to be_invalid
        expect(post_stamp.errors[:stamp]).to eq ["を入力してください"]
      end

      it '重複したstampとpost_idとuser_idの組み合わせがあるとき無効' do
        post_stamp1 = create(:post_stamp)
        post_stamp2 = build(:post_stamp, user_id: post_stamp1.user_id, post_id: post_stamp1.post_id, stamp: post_stamp1.stamp)
        expect(post_stamp2).to be_invalid
        expect(post_stamp2.errors[:stamp]).to eq ["はすでに存在します"]
      end
    end
  end
end
