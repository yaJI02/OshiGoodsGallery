require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'Tag#create' do
    let(:tag) { build(:tag) }

    context '正常に作成される時' do
      it '有効になること' do
        expect(tag).to be_valid
        expect(tag.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'nameがなければ無効' do
        tag.name = nil
        expect(tag).to be_invalid
        expect(tag.errors[:name]).to eq ["を入力してください"]
      end

      it 'nameが255文字より多いなら無効' do
        tag.name = 'a' * 256
        expect(tag).to be_invalid
        expect(tag.errors[:name]).to eq ["は255文字以内で入力してください"]
      end

      it 'tag_typeがなければ無効' do
        tag.tag_type = nil
        expect(tag).to be_invalid
        expect(tag.errors[:tag_type]).to eq ["を入力してください"]
      end
    end
  end
end
