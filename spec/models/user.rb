require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
	  it "有効な場合は保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    context 'nameカラム' do
      it '空欄でないこと' do
        user = build(:user, name: "")
        expect(user).to be_invalid
      end
    end

    context 'statusカラム' do
      it '空欄でないこと' do
        user = build(:user, status: nil)
        expect(user).to be_invalid
      end
    end

    context 'ageカラム' do
      it '空欄でないこと' do
        user = build(:user, age: nil)
        expect(user).to be_invalid
      end
    end

    context 'heightカラム' do
      it '空欄でないこと' do
        user = build(:user, height: nil)
        expect(user).to be_invalid
      end
    end

    context 'experienceカラム' do
      it '空欄でないこと' do
        user = build(:user, experience: nil)
        expect(user).to be_invalid
      end
    end

    context 'club_statusカラム' do
      it '空欄でないこと' do
        user = build(:user, club_status: nil)
        expect(user).to be_invalid
      end
    end

    context 'areaカラム' do
      it '空欄でないこと' do
        user = build(:user, area: nil)
        expect(user).to be_invalid
      end
    end

    context 'targetカラム' do
      it '空欄でないこと' do
        user = build(:user, target: nil)
        expect(user).to be_invalid
      end
    end

  end
end