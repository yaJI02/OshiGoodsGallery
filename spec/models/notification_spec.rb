require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'Notification#create' do
    context '正常に作成される時' do
      it 'Commentに関連付いたNotificationが作成される' do
        notification = create(:notification_for_comment)
        expect(notification).to be_valid
        expect(notification.errors).to be_empty
      end

      it 'PostStampに関連付いたNotificationが作成される' do
        notification = create(:notification_for_post_stamp)
        expect(notification).to be_valid
        expect(notification.errors).to be_empty
      end

      it 'Userに関連付いたNotificationが作成される' do
        notification = create(:notification_for_user)
        expect(notification).to be_valid
        expect(notification.errors).to be_empty
      end
    end

    context '異常になる時' do
      it 'action_typeがなければ無効' do
        notification = build(:notification_for_comment, action_type: nil)
        expect(notification).to be_invalid
        expect(notification.errors[:action_type]).to eq ["を入力してください"]
      end

      it 'checkedがなければ無効' do
        notification = build(:notification_for_comment, checked: nil)
        expect(notification).to be_invalid
        expect(notification.errors[:checked]).to eq ["は一覧にありません"]
      end
    end

    context 'Commentが投稿される時' do
      it 'Notificationが自動的に作成されること' do
        expect {
          create(:comment)
        }.to change(Notification, :count).by(1)

        comment = Comment.last
        notification = Notification.find_by(subject: comment)
        expect(notification).not_to be_nil
      end
    end

    context 'PostStampが投稿される時' do
      it 'Notificationが自動的に作成されること' do
        expect {
          create(:post_stamp)
        }.to change(Notification, :count).by(1)

        post_stamp = PostStamp.last
        notification = Notification.find_by(subject: post_stamp)
        expect(notification).not_to be_nil
      end
    end

    context 'Followが投稿される時' do
      it 'Notificationが自動的に作成されること' do
        expect {
          create(:follow)
        }.to change(Notification, :count).by(1)

        follow = Follow.last
        notification = Notification.find_by(subject: follow)
        expect(notification).not_to be_nil
      end
    end
  end
end
