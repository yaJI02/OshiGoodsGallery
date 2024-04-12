require 'rails_helper'

RSpec.describe ChoosyTag, type: :model do
  describe 'ChoosyTag#create' do
    context '正常に作成される時' do
      it '有効になること' do
        choosy_tag = build(:choosy_tag)
        expect(choosy_tag).to be_valid
        expect(choosy_tag.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'choosy_typeがなければ無効' do
        choosy_tag = build(:choosy_tag, choosy_type: nil)
        expect(choosy_tag).to be_invalid
        expect(choosy_tag.errors[:choosy_type]).to eq ["を入力してください"]
      end
    end
  end
end
