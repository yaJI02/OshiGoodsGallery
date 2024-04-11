require 'rails_helper'

RSpec.describe Place, type: :model do
  describe 'Place#create' do
    let(:place) { build(:place) }

    context '正常に作成される時' do
      it '有効になること' do
        expect(place).to be_valid
        expect(place.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'nameがなければ無効' do
        place.name = nil
        expect(place).to be_invalid
        expect(place.errors[:name]).to eq ["を入力してください"]
      end

      it 'nameが255文字より多いなら無効' do
        place.name = 'a' * 256
        expect(place).to be_invalid
        expect(place.errors[:name]).to eq ["は255文字以内で入力してください"]
      end
    end
  end
end
