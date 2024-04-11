require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Profile#create' do
    let(:profile) { build(:profile) }

    context '正常に作成される時' do
      it '有効になること' do
        expect(profile).to be_valid
        expect(profile.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'sns_accountが255文字より多いなら無効' do
        profile.sns_account = 'a' * 256
        expect(profile).to be_invalid
        expect(profile.errors[:sns_account]).to eq ["は255文字以内で入力してください"]
      end

      it 'display_tag_typeがなければ無効' do
        profile.display_tag_type = nil
        expect(profile).to be_invalid
        expect(profile.errors[:display_tag_type]).to eq ["を入力してください"]
      end

      it 'is_display_dislike_tagがなければ無効' do
        profile.is_display_dislike_tag = nil
        expect(profile).to be_invalid
        expect(profile.errors[:is_display_dislike_tag]).to eq ["は一覧にありません"]
      end
    end
  end
end
