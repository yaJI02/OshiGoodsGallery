require 'rails_helper'

RSpec.describe PostPlace, type: :model do
  describe 'PostPlace#create' do
    context '正常に作成される時' do
      it '有効になること' do
        post_place = build(:post_place)
        expect(post_place).to be_valid
        expect(post_place.errors).to be_empty
      end
    end

    context '異常になる時' do
      it '重複したpost_idとplace_idの組み合わせがあるとき無効' do
        post_place1 = create(:post_place)
        post_place2 = build(:post_place, place_id: post_place1.place_id, post_id: post_place1.post_id)
        expect(post_place2).to be_invalid
        expect(post_place2.errors[:post_id]).to eq ["はすでに存在します"]
      end
    end
  end
end
