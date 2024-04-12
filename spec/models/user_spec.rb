require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User#create' do
    let(:user) { build(:user) }

    context '正常に作成される時' do
      it '有効になること' do
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'passwordが5文字未満なら無効' do
        user.password = '1234'
        user.password_confirmation = '1234'
        expect(user).to be_invalid
        expect(user.errors[:password]).to eq ["は5文字以上で入力してください"]
      end

      it 'password_confirmationが一致しなければ無効' do
        user.password = '12345'
        user.password_confirmation = '12346'
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません"]
      end

      it 'password_confirmationがなければ無効' do
        user.password = '12345'
        user.password_confirmation = nil
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to eq ["を入力してください"]
      end

      it 'passwordがなければ無効' do
        user.password = nil
        user.password_confirmation = '12345'
        expect(user).to be_invalid
        expect(user.errors[:password]).to eq ["は5文字以上で入力してください"]
      end

      it '重複したemailなら無効' do
        user1 = create(:user, email: 'test1@example.com')
        user2 = build(:user, email: 'test1@example.com')
        expect(user2).to be_invalid
        expect(user2.errors[:email]).to eq ["はすでに存在します"]
      end

      it '重複しないemailなら有効' do
        user1 = create(:user, email: 'test1@example.com')
        user2 = build(:user, email: 'test2@example.com')
        expect(user2).to be_valid
        expect(user2.errors[:email]).to be_empty
      end

      it 'emailがなければ無効' do
        user.email = nil
        expect(user).to be_invalid
        expect(user.errors[:email]).to eq ["を入力してください"]
      end

      it 'nameがなければ無効' do
        user.name = nil
        expect(user).to be_invalid
        expect(user.errors[:name]).to eq ["を入力してください"]
      end

      it 'nameが255文字より多いなら無効' do
        user.name = 'a' * 256
        expect(user).to be_invalid
        expect(user.errors[:name]).to eq ["は255文字以内で入力してください"]
      end
    end
  end
end
