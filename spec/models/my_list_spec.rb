require 'rails_helper'

RSpec.describe MyList, type: :model do
  describe 'MyList#create' do
    context '正常に作成される時' do
      it '有効になること' do
        my_list = build(:my_list)
        expect(my_list).to be_valid
        expect(my_list.errors).to be_empty
      end
    end

    context '異常になる時' do
      it '重複したuser_idとpost_idの組み合わせがあるとき無効' do
        my_list1 = create(:my_list)
        my_list2 = build(:my_list, user_id: my_list1.user_id, post_id: my_list1.post_id)
        expect(my_list2).to be_invalid
        expect(my_list2.errors[:user_id]).to eq ["はすでに存在します"]
      end
    end
  end
end
