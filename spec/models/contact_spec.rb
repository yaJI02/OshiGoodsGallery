require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'Contact#create' do
    let(:contact) { build(:contact) }

    context '正常に作成される時' do
      it '有効になること' do
        expect(contact).to be_valid
        expect(contact.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'nameがなければ無効' do
        contact.name = nil
        expect(contact).to be_invalid
        expect(contact.errors[:name]).to eq ["を入力してください"]
      end

      it 'nameが255文字より多いなら無効' do
        contact.name = 'a' * 256
        expect(contact).to be_invalid
        expect(contact.errors[:name]).to eq ["は255文字以内で入力してください"]
      end

      it 'emailがなければ無効' do
        contact.email = nil
        expect(contact).to be_invalid
        expect(contact.errors[:email]).to eq ["を入力してください"]
      end

      it 'emailが255文字より多いなら無効' do
        contact.email = 'a' * 256
        expect(contact).to be_invalid
        expect(contact.errors[:email]).to eq ["は255文字以内で入力してください"]
      end

      it 'email_confirmationがなければ無効' do
        contact.email_confirmation = nil
        expect(contact).to be_invalid
        expect(contact.errors[:email_confirmation]).to eq ["を入力してください"]
      end

      it 'email_confirmationが255文字より多いなら無効' do
        contact.email = 'a' * 256
        contact.email_confirmation = 'a' * 256
        expect(contact).to be_invalid
        expect(contact.errors[:email_confirmation]).to eq ["は255文字以内で入力してください"]
      end

      it 'email_confirmationが一致しなければ無効' do
        contact.email = '12345@example.com'
        contact.email_confirmation = '12346@example.com'
        expect(contact).to be_invalid
        expect(contact.errors[:email_confirmation]).to eq ["が一致しません"]
      end

      it 'subjectがなければ無効' do
        contact.subject = nil
        expect(contact).to be_invalid
        expect(contact.errors[:subject]).to eq ["を入力してください"]
      end

      it 'messageがなければ無効' do
        contact.message = nil
        expect(contact).to be_invalid
        expect(contact.errors[:message]).to eq ["を入力してください"]
      end

      it 'messageが255文字より多いなら無効' do
        contact.message = 'a' * 65536
        expect(contact).to be_invalid
        expect(contact.errors[:message]).to eq ["は65535文字以内で入力してください"]
      end

      it 'login_userが255文字より多いなら無効' do
        contact.login_user = '1' * 256
        expect(contact).to be_invalid
        expect(contact.errors[:login_user]).to eq ["は255文字以内で入力してください"]
      end
    end
  end
end
