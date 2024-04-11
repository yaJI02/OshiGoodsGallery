require 'rails_helper'

RSpec.describe PostTag, type: :model do
  describe 'PostTag#create' do
    context '正常に作成される時' do
      it '有効になること' do
        post_tag = build(:post_tag)
        expect(post_tag).to be_valid
        expect(post_tag.errors).to be_empty
      end
    end

    context '異常になる時' do
      it '重複したpost_idとtag_idの組み合わせがあるとき無効' do
        post_tag1 = create(:post_tag)
        post_tag2 = build(:post_tag, tag_id: post_tag1.tag_id, post_id: post_tag1.post_id)
        expect(post_tag2).to be_invalid
        expect(post_tag2.errors[:post_id]).to eq ["はすでに存在します"]
      end
    end
  end
end
