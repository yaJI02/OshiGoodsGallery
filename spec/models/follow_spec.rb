require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'Follow#create' do
    context '正常に作成される時' do
      it '有効になること' do
        notification = create(:follow)
        expect(notification).to be_valid
        expect(notification.errors).to be_empty
      end
    end

    context '異常になる時' do
      it '重複したfollowerとfollowedの組み合わせがあるとき無効' do
        follow1 = create(:follow)
        follow2 = build(:follow, follower: follow1.follower, followed: follow1.followed)
        expect(follow2).to be_invalid
        expect(follow2.errors[:follower]).to eq ["はすでに存在します"]
      end
    end
  end
end
