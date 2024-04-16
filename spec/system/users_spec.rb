require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー・プロフィールの新規登録ができてプロフィールページに移動する' do
      # トップページに移動する
      visit root_path
      # 新規登録ページへ遷移するボタンをクリック
      click_link '新規登録'
      # 新規登録ページへ移動した事を確認
      expect(current_path).to eq new_user_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: 'test_user'
      fill_in 'user_email', with: 'test@example'
      fill_in 'user_password', with: 'testpassword'
      fill_in 'user_password_confirmation', with: 'testpassword'
      #「新規登録する」ボタンを押すとユーザーモデルとプロフィールモデルのカウントが1上がることを確認する
      expect{ find('input[name="commit"]').click }.to change { User.count }.by(1).and change { Profile.count }.by(1)
      #プロフィール編集画面に移動した事を確認
      profile_id = Profile.last.id
      expect(current_path).to eq edit_profile_path(profile_id)
      #表示されているプロフィール情報が正しいことを確認
      expect(page).to have_content('test_user')
      # プロフィール情報を入力する
      fill_in 'profile_user_name', with: 'test_user_rev1'
      image_path = Rails.root.join('app/assets/images/sample.jpg')
      attach_file 'profile_avatar', image_path
      fill_in 'profile_sns_account', with: '@test_sns_account'
      choose 'NGタグ以外'
      #「更新する」ボタンを押すとプロフィールが更新される
      expect{ find('input[name="commit"]').click }.to change { Profile.find(profile_id).user.name }.from('test_user').to('test_user_rev1')
      expect(Profile.find(profile_id).sns_account).to eq '@test_sns_account'
      # プロフィール詳細画面へ遷移している事を確認する
      expect(current_path).to eq profile_path(profile_id)
      # 更新したプロフィール情報が表示されている事を確認
      expect(page).to have_content('test_user_rev1')
      expect(page).to have_selector('img[src$="sample.jpg"]')
      expect(page).to have_content('@test_sns_account')
      expect(page).to have_content('NGタグ以外の投稿を表示する')
    end
  end
end
