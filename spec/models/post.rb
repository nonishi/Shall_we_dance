require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    it "有効な場合は保存されるか" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end
end
